# Journali

Journali is a personal journaling app for iOS. It lets you write, organize, and revisit your thoughts in a clean dark interface that follows Apple's native design.

## Main Features

- Splash screen that transitions automatically to the main page
- Empty state that guides you to write your first journal
- Create a new journal entry with a title and content
- Edit an existing journal entry
- Delete a journal with swipe and a confirmation alert
- Bookmark your favorite or important entries
- Sort entries by bookmark or by entry date
- Search journals by title or content
- Discard changes alert when closing an edited entry
- Journals are saved on the device and remain after closing the app

## Technologies Used

- Swift
- SwiftUI
- MVVM architecture (Model, ViewModel, View)
- `Codable` and `UserDefaults` for data persistence
- Native components: `NavigationStack`, `.toolbar`, `.searchable`, `.swipeActions`, `.sheet`, `.alert`
- Icon Composer for the app icon
- Dark mode support

## Project Structure

- `Models/` : `JournalEntry`
- `ViewModels/` : `JournalViewModel`
- `Views/` : `SplashView`, `RootView`, `MainView`, `JournalCard`, `EmptyStateView`, `EditJournalView`
- `Theme/` : `Color+Theme`


