# KoinWorks iOS Assesment

Create a simple Crypto Currencies app using CoinGecko API, contains a list page and a details information page. Product and tech specification as described below.


### Product Requirement
* Set the default sorting by largest market cap.
* Infinite scroll pagination, 15 items per page.
* Each item in the list must display following information: 
```
icon
name
symbol
current USD price
current price change percentage (24-hour).
```

* Details page consists of following information
```
icon
name
symbol
current USD price
market cap
market cap rank
current price change percentage (24-hour, 7-day, 30-day, 1-year) in horizontal view.
asset description
Market Charts
```

### Tech Implemented
- iPhone only, potrait mode, iOS 13 target.
- Xib UI.
- 3rd-party SDK (Alamofire, SDWebImage, DSFSparkline, Localize-Swift, Cuckoo).
- Reactive using Combine
- Handle API error and present message in the app.
- Utilize Swift feature (i.e enum, protocol, generic, etc)
- Provide UI to switch beetween language between English & Indonesia (reflected to asset's price currency, name, and description).
- Local persistent storage.
- MVC architecture.
- Unit Tests.


### Reference
- CoinGecko's [Swagger Doc](https://app.swaggerhub.com/apis/coingecko/coingecko_api/3.0.0)


### List API
- `/coins/markets`
- `/coins/{id}`
- `/coins/{id}/market_chart?vs_currency={vs_currency}&days={days}`
