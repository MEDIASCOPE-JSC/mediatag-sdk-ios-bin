# Как выпускать релизы

Правило: **никогда не указывать в `binaryTarget` ссылку `archive/refs/tags/*.zip`.** Это автоархив GitHub: он содержит сам `Package.swift`, поэтому чек-сумму заранее посчитать нельзя, и байты архива не гарантированы. Всегда используется zip, загруженный как файл релиза.

1. Обновить `MediatagSDK.xcframework` и закоммитить (чек-сумму в `Package.swift` пока не менять).
2. Собрать архив из корня репозитория. Папка xcframework должна лежать в корне zip:
   ```
   zip -qry -X MediatagSDK.xcframework.zip MediatagSDK.xcframework
   ```
3. Посчитать чек-сумму именно этого файла:
   ```
   swift package compute-checksum MediatagSDK.xcframework.zip
   ```
4. В `Package.swift` указать `url`
   `https://github.com/MEDIASCOPE-JSC/mediatag-sdk-ios-bin/releases/download/<VERSION>/MediatagSDK.xcframework.zip`
   и `checksum` из шага 3. Закоммитить.
5. Создать тег `<VERSION>` на этом коммите и GitHub Release. Приложить **тот же** zip из шага 2 (не пересобирать).
6. Перед объявлением релиза проверить установку с чистого состояния:
   ```
   rm -rf ~/Library/Caches/org.swift.swiftpm
   swift package resolve   # в тестовом проекте, который зависит от этого тега
   ```
7. Не переносить и не пересоздавать опубликованный тег и не заменять файл в релизе: любое изменение zip меняет чек-сумму и ломает всех, у кого она уже записана. Если что-то не так, выпускать новую версию.
8. Обновить версию в README (`from: "<VERSION>"`, строка для CocoaPods).
