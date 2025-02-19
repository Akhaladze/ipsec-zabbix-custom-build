import re
import json
import pandas as pd
import sqlite3

# Function to parse test results and serialize them into a structured table
def parse_test_results(file_path):
    results = []
    current_node_ip = None

    # Define the IP range for validation
    ip_range_pattern = r"^172\.16\.1[6-9]\.\d+$|^172\.16\.2[0-5]\.\d+$"

    with open(file_path, 'r') as file:
        lines = file.readlines()

    for i, line in enumerate(lines):
        # Identify the client IP from the header
        if "Connecting to host" in line:
            match = re.search(r"Connecting to host (\d+\.\d+\.\d+\.\d+),", line)
            if match:
                candidate_ip = match.group(1)
                if re.match(ip_range_pattern, candidate_ip):
                    current_node_ip = candidate_ip


        # Extract test data lines
        match = re.search(r"\[\s*\d+\]\s+(\d+\.\d+)-(\d+\.\d+)\s+sec\s+(\d+\.\d+)\s+([MG]Bytes)\s+(\d+\.\d+)\s+Mbits/sec\s+(\d+\.\d+)\s+ms\s+(\d+)/(\d+)\s+\((\d+\.\d+)%\)", line)
        if match and current_node_ip:
            interval_start = int(float(match.group(1)))  # Use only interval_start (e.g., 10, 20, 30, ...)
            transfer_unit = match.group(4)  # Capture transfer unit (MBytes or GBytes)
            transfer = float(match.group(3)) * (1024 if transfer_unit == "GBytes" else 1)  # Convert GBytes to MBytes if needed
            bitrate = float(match.group(5))
            jitter = float(match.group(6))
            lost = int(match.group(7))
            total = int(match.group(8))
            datagram_loss = float(match.group(9))

            results.append({
                "node_ip": current_node_ip,
                "interval_start": interval_start,
                "transfer": transfer,
                "bitrate": bitrate,
                "jitter": jitter,
                "lost": lost,
                "total": total,
                "datagram_loss": datagram_loss,
            })

    return results

# Function to save results to SQLite
def save_to_sqlite(df, db_name="result.db"):
    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()

    # Create the tests table if it doesn't exist
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS tests (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            node_ip TEXT,
            interval_start REAL,
            interval_end REAL,
            transfer REAL,
            bitrate REAL,
            jitter REAL,
            lost INTEGER,
            total INTEGER,
            datagram_loss REAL
        )
    ''')

    # Insert data into the table
    df.to_sql('tests', conn, if_exists='append', index=False)
    conn.commit()
    conn.close()
    print(f"Data successfully saved to {db_name}")

def main():
    # File path
    file_path = "iperf_results-300-nodes-2M.log"

    # Parse the test results
    try:
        results = parse_test_results(file_path)

        # Serialize results to a DataFrame and display
        df = pd.DataFrame(results)
        print(df)

        # Save to SQLite database
        save_to_sqlite(df)
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
