#!/bin/bash

# Define the output CSV file
output_csv="output.csv"

# Initialize the header row
header=""

# Initialize an array to store rows
rows=()

# Iterate over each log file
for log_file in *.log; do
    # Extract the header name (filename without .log)
    column_name="${log_file%.log}"
    
    # Add the header column name
    if [ -z "$header" ]; then
        header="$column_name"
    else
        header="$header,$column_name"
    fi
    
    # Process each log file's content
    row_content=""
    while read -r value; do
        # Convert KB values exceeding 10 to MB
        if (( $(echo "$value > 10" | bc -l) )); then
            # Prepend "0." to convert KB to MB
            value=$(echo "scale=4; 0.$value" | bc)
        fi
        
        # Append the value to the row, separated by commas
        if [ -z "$row_content" ]; then
            row_content="$value"
        else
            row_content="$row_content,$value"
        fi
    done < "$log_file"
    
    # Append the processed row to the rows array
    rows+=("$row_content")
done

# Write the header to the CSV file
echo "$header" > "$output_csv"

# Write each row to the CSV file
for row in "${rows[@]}"; do
    echo "$row" >> "$output_csv"
done

echo "CSV file created: $output_csv"
