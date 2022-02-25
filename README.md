# CBAppleMusicAPI

A Swift package to simplify reading data from the Apple Music API:

https://developer.apple.com/documentation/applemusicapi/

This package was created initially for use in Streaks Workout (https://streaksworkout.app), so as such, there may be missing parts of the API which we will aim to fill out over time.

We welcome pull requests to fill out these missing parts.

---

Sample Usage:

```swift
let developerToken = fetchDeveloperToken()

let api = AppleMusicAPI(
    developerToken: developerToken,
    countryCode: "au"
)

api.searchPlaylists(term: "workout") { result in
    switch result {
        case .failure(let error):
            // Handle error
        case .success(let playlists):
            // Handle playlists
    }
}
```
