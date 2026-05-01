# istories
web-api for istories.media Документальные фильмы и репортажи из России и не только. Расследования о военных преступлениях и коррупции. Работаем для вас без цензуры и запретных тем.
# main
```swift
import Foundation
import istories
let client = Istories()

do {
    let news_list = try await client.get_news()
    print(news_list)
} catch {
    print("Error: \(error)")
}
```

# Launch (your script)
```
swift run
```
