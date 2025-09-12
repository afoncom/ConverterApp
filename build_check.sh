#!/bin/bash

echo "🚀 Проверка сборки проекта CurrencyConverter..."

PROJECT_PATH="/Users/afon.com/Desktop/iOS-разработка/Swift для начин. и приложения/CurrencyConverter/CurrencyConverter.xcodeproj"

# Очистка DerivedData
echo "🧹 Очистка DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData/CurrencyConverter-*

# Попытка сборки проекта
echo "🔨 Попытка сборки проекта..."
xcodebuild -project "$PROJECT_PATH" -scheme "CurrencyConverter" -sdk iphonesimulator -configuration Debug clean build

if [ $? -eq 0 ]; then
    echo "✅ Проект собран успешно!"
else
    echo "❌ Ошибки при сборке проекта."
    echo "💡 Возможные решения:"
    echo "  1. Проверьте пути к файлам в настройках проекта"
    echo "  2. Убедитесь, что все файлы правильно добавлены в проект"
    echo "  3. Проверьте настройки Build Settings в Xcode"
fi
