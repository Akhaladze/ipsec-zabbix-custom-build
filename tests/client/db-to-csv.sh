#!/bin/bash

# Параметры
DB_NAME="test_result_300-2M.db"
OUTPUT_FILE="test_result_300-2M.csv"

# Проверка существования базы данных
if [[ ! -f "$DB_NAME" ]]; then
  echo "Ошибка: Файл базы данных $DB_NAME не найден."
  exit 1
fi

# Извлечение данных из таблицы tests в CSV
sqlite3 -header -csv "$DB_NAME" "SELECT * FROM tests;" > "$OUTPUT_FILE"

# Проверка успеха
if [[ $? -eq 0 ]]; then
  echo "Данные успешно экспортированы в файл $OUTPUT_FILE."
else
  echo "Ошибка при экспорте данных."
  exit 2
fi
