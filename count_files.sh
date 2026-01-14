TARGET_DIR="/etc"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Помилка: директорія $TARGET_DIR не існує"
    exit 1
fi

file_count=$(find "$TARGET_DIR" -maxdepth 1 -type f | wc -l)

echo "======================================"
echo "Підрахунок файлів у директорії $TARGET_DIR"
echo "======================================"
echo ""
echo "Кількість звичайних файлів: $file_count"
echo ""
exit 0
