#!/bin/bash

# Масив з URL вебсайтів для перевірки
websites=("https://google.com" "https://facebook.com" "https://twitter.com")

# Файл для запису результатів
log_file="website_status.log"

# Очищення або створення нового файлу логів
> "$log_file"

echo "Starting website status check..."
echo "Results will be logged in $log_file"

# Перевірка кожного вебсайту
for website in "${websites[@]}"; do
    # Використання curl для перевірки доступності
    response=$(curl -o /dev/null -s -w "%{http_code}" "$website")
    
    if [ "$response" -eq 200 ]; then
        status="is UP"
    else
        status="is DOWN"
    fi

    # Запис результатів у лог-файл
    echo "<$website> $status" >> "$log_file"
done

# Підсумкове повідомлення
echo "Website status check completed."
echo "Results have been logged in $log_file"
