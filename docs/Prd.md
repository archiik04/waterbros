# WATERBROS - Complete Product Requirements Document
## Production-Ready Build Specification for AntiGravity Development

**Version:** 2.0 Production  
**Status:** Ready for Development  
**Last Updated:** June 2026  
**Target Launch:** Week 8 (8-week sprint)  
**Platform:** Flutter (iOS 13.0+ / Android 8.0+)  

---

## TABLE OF CONTENTS
1. Design Reference & Visual System
2. Feature Specifications (Screen-by-Screen)
3. User Flows & Wireframe Descriptions
4. Technical Architecture
5. API Specifications
6. Database Schema & Models
7. Authentication & Security
8. Analytics & Event Tracking
9. Testing & QA Checklist
10. App Store Requirements & Submission
11. Performance & Optimization
12. Edge Cases & Error Handling
13. Deployment & Release Strategy

---

# PART 1: DESIGN REFERENCE & VISUAL SYSTEM

## 1.1 Design Philosophy

**Inspiration:** Matiks (clean, minimal, competition-focused) + Strava (social layers) + Apple Health (clarity)

**Core Principles:**
- **Clarity over ornament:** Every pixel serves a purpose
- **Cognitive clarity:** Users should understand what happened, what's happening, what's next
- **Minimal motion:** Motion only for structure, not decoration (not like 2025 theatrics)
- **Competition-first:** All screens should elevate the competitive aspect
- **Social proof:** Leaderboards, buddy progress, achievements visible immediately
- **Accessibility:** All interactions must be keyboard/voice accessible

## 1.2 Color Palette

### Primary Colors
```
Brand Blue: #2563EB (primary CTA, highlights)
Water Cyan: #06B6D4 (secondary, hydration/water indicator)
Accent Green: #10B981 (achievements, success states)
Dark Background: #0F172A (navy-dark for dark mode)
Light Background: #F8FAFC (light mode)
Neutral Gray: #64748B (text, secondary elements)
Error Red: #EF4444 (errors, dehydration alerts)
```

### Usage Rules
- Primary Blue: Buttons, active states, focus indicators
- Water Cyan: Water amount visual, progress fills, buddy highlights
- Accent Green: Achievements, streak milestones, goal completion
- Gray: Body text, secondary info, dividers
- Background colors: Follow system (light/dark mode)

## 1.3 Typography

### Font Stack (Fallback Order)
```
Primary: SF Pro Display (iOS native), Roboto (Android native)
Fallback 1: Inter
Fallback 2: System Font Stack

Monospace (stats): Courier New / Roboto Mono
```

### Type Scale
```
H1 (Display): 32px, Weight 700, Line Height 1.2
  Usage: Main app titles, "50" in level display

H2 (Heading): 24px, Weight 600, Line Height 1.3
  Usage: Screen titles ("Leaderboard", "Buddy"), buddy names

H3 (Subheading): 18px, Weight 600, Line Height 1.4
  Usage: Section headers, card titles

Body Large: 16px, Weight 400, Line Height 1.5
  Usage: Primary text, challenge descriptions, logs

Body Regular: 14px, Weight 400, Line Height 1.5
  Usage: Secondary text, timestamps, helper text

Caption: 12px, Weight 400, Line Height 1.4
  Usage: Labels, XP amounts, streak counts

Button: 14px, Weight 600, Line Height 1.4
  Usage: All button text, ALL CAPS for emphasis

Stat Value: 28px, Weight 700, Monospace
  Usage: XP amounts, water amounts, streak numbers
```

## 1.4 Spacing & Layout

### Grid System
```
Base Unit: 8px
Spacing scale: 4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px

Margins:
  Screen edge: 16px (mobile), 24px (tablet)
  Card padding: 16px
  Button padding: 12px vertical, 16px horizontal

Border Radius:
  Small buttons, icons: 8px
  Cards, modals: 12px
  Large surfaces: 16px
  Fully rounded: 24px (for avatar circles)
```

## 1.5 Component Library (Figma Design System)

### Buttons
- **Primary Button:** 44px height, blue background, white text, shadow on press
- **Secondary Button:** 44px height, gray background, dark text, no shadow
- **Tertiary Button:** Text-only, blue text, no background
- **Icon Button:** 48x48px min touch target, transparent background, scaling on press
- **Floating Action Button:** 56x56px circular, blue, shadow, always bottom-right

### Card Components
- **Standard Card:** White bg (light mode) / Dark bg (dark mode), 12px radius, subtle shadow
- **Buddy Card:** Shows avatar, name, progress ring, current status
- **Challenge Card:** Title, time remaining, participants count, join button
- **Stat Card:** Icon, label, value (monospace), optional subtitle

### Input Components
- **Text Field:** 44px height, clear focus state, error state styling
- **Number Input:** Spinner buttons OR tap-to-increment
- **Dropdown:** Height 44px, chevron indicator, scroll list on tap

### Progress Indicators
- **Linear Progress:** Used for daily goal (bottom-aligned fill, animated)
- **Circular Progress:** Used for buddy comparison, level progression (animated)
- **Streak Counter:** Visual badge with flame icon 🔥 + number

### Navigation
- **Tab Bar (Bottom):** 5 tabs max, icon + label, active state = solid blue
- **Top Navigation Bar:** Title centered, back button left, optional action right
- **Drawer/Menu:** Hamburger (Android), slide-in from left

## 1.6 Motion & Animation

### Entrance Animations
```
Screen entrance: Fade in 200ms ease-in-out
Card entrance (staggered): Slide up 8px + fade, 200ms, 50ms stagger
Button press: Scale 0.95, 100ms
```

### Loading States
```
Skeleton screens: 200ms pulse animation, gray placeholder
Loading spinner: 16px animated circle, blue color
No animation on critical states (don't over-animate)
```

### Feedback Animations
```
Log water button: Scale + 200ms animation to expand ring
XP notification: Toast slide-in from top, 300ms, auto-dismiss 2.5s
Streak gained: Subtle confetti (Lottie), 1s duration
Level up: Modal scale-in + sound cue (optional)
```

### Micro-interactions
```
Buddy notification: Real-time highlight with subtle blue pulse
Leaderboard rank change: Smooth position transition 300ms
Toggle state change: 100ms spring animation
```

## 1.7 Dark Mode Implementation

### Strategy
- Use Flutter's `ThemeData` with `brightness: Brightness.dark`
- All colors defined as `Color(light: light, dark: dark)` in design tokens
- Respect system setting, allow manual override in settings
- Test all screens in both modes

### Dark Mode Colors
```
Background: #0F172A (dark navy)
Surface: #1E293B (slightly lighter, for cards)
Text Primary: #F1F5F9 (light gray)
Text Secondary: #94A3B8 (medium gray)
Divider: #334155 (darker gray)
Blue (unchanged): #2563EB
Cyan (slightly muted): #06B6D4 → #0891B2 (darker mode)
```

---

# PART 2: FEATURE SPECIFICATIONS (SCREEN-BY-SCREEN)

## 2.1 Onboarding Flow (5 Screens)

### Screen 1: Welcome
**Screen Name:** `OnboardingWelcome`

**Layout:**
- Top: Illustration (water droplet + person, 240x240px, centered)
- Headline: "Stay Hydrated, Win Together"
- Subheading: "Track water, compete with friends, climb the leaderboard"
- Button: "Get Started" (blue, primary)
- Bottom: "Already have an account? Sign In" (tertiary link)

**Interactions:**
- CTA: Navigate to auth screen
- Sign In link: Navigate to login

---

### Screen 2: Auth (Sign Up / Login)
**Screen Name:** `AuthScreen`

**Sections:**
1. **Logo & Title:** "WaterBros" (24px, centered)
2. **Tab Selection:** "Sign Up" / "Log In" (segmented control)
3. **Input Fields (Sign Up Mode):**
   - Email field (type: email, placeholder: "you@example.com")
   - Password field (type: password, toggle show/hide)
   - Confirm Password field
   - Error states: "Email already in use", "Passwords don't match"
4. **Social Auth:** 
   - "Continue with Google" button (Google branding)
   - "Continue with Apple" button (Apple branding)
   - Divider: "or"
5. **Primary CTA:** "Create Account" (blue, 44px)
6. **Footer:** Terms link + Privacy link (12px caption)

**Input Validation:**
- Email: RFC 5322 validation, check existence in real-time (500ms debounce)
- Password: Min 8 chars, 1 uppercase, 1 number, 1 special char
- Confirm: Match check on blur
- Real-time feedback: Green checkmark on valid, red error on blur

**Error Handling:**
- Network error: "Connection failed. Check your internet." (bottom banner)
- 409 conflict: "Email already registered. Log in instead."
- Server error: "Something went wrong. Please try again." + retry button

**Social Auth Flow:**
- Redirect to provider
- Handle callback
- If new user: Create account, proceed to profile setup
- If existing: Proceed to home

---

### Screen 3: Profile Setup
**Screen Name:** `ProfileSetupScreen`

**Components:**
1. **Avatar Upload Section:**
   - Circular placeholder (96x96px), camera icon overlay
   - Tap to open image picker (camera or gallery)
   - Cropping UI with 1:1 aspect ratio
   - Allow skip

2. **Form Fields:**
   - Username (14-30 chars, alphanumeric + underscore, availability check)
   - Bio (optional, max 150 chars, show char count)
   - Pronouns (dropdown: He/Him, She/Her, They/Them, Custom)
   
3. **Health Profile:**
   - Activity Level (radio buttons):
     * Sedentary
     * Lightly Active
     * Moderately Active
     * Very Active
   - Climate Region (dropdown):
     * Cold / Temperate / Hot / Tropical
   - Special Conditions (checkboxes):
     * Pregnant/Breastfeeding
     * Medical Condition (opens disclosure)
   
4. **Daily Goal Calculation:**
   - System calculates: Base (2L) + Activity adjustment + Climate adjustment
   - Show formula: "Your goal: 2.5L based on your activity level"
   - Allow manual override with input field

5. **CTA:** "Create My Profile" (blue, 44px)

**Validation:**
- Username: Real-time availability check via API (debounced)
- Bio: Character count warning at 140+ chars
- Health data: All required before proceeding

**Skip Logic:**
- Avatar: Can skip, use placeholder
- Bio/Pronouns: Can skip
- Health data: Required (at least activity level)

---

### Screen 4: Add First Buddy (Optional, Skippable)
**Screen Name:** `AddBuddyOnboarding`

**Copy:** "Invite a friend to stay accountable. Optional, you can add buddies anytime."

**Options:**
1. **Search by Username:**
   - Input field (search as you type)
   - Results list (avatar + username + mutual buddy count)
   - Tap to send buddy request

2. **Scan QR Code:**
   - Button: "Scan QR Code"
   - Opens camera with QR detector
   - Shows buddy info on scan
   - Confirm: "Send Request to [Name]"

3. **Copy Invite Link:**
   - Button: "Get Invite Link"
   - Shows shareable link (e.g., waterbros.app/invite/ABC123)
   - Copy button + share sheet

4. **Skip:** "I'll add friends later" (tertiary link)

**Request Flow:**
- Show success: "Request sent to [Name]!"
- Navigate to home OR add another buddy

---

### Screen 5: Notifications Permission
**Screen Name:** `NotificationPermissionsScreen`

**Content:**
- Headline: "Get Reminders to Stay Hydrated"
- Description: "We'll remind you to drink water at the right times based on your activity"
- Illustration: Bell icon with water drops
- Buttons:
  - "Enable Notifications" (primary, requests permission)
  - "Maybe Later" (secondary)

**Permission Handling:**
- iOS: Use `requestUserNotificationPermissions()`
- Android: Check `PERMISSION_POST_NOTIFICATIONS` (API 33+)
- On grant: Show "Permissions enabled" toast, proceed to home
- On deny: Still proceed to home, but log event

---

## 2.2 Home Tab (Core Dashboard)

### Screen: Home Dashboard
**Screen Name:** `HomeScreen`

**Layout (Scrollable Column):**

#### Header Section (Fixed or Sticky)
- **Top Bar:**
  - Left: Hamburger menu (drawer toggle) | Center: "WaterBros" logo | Right: Settings icon
  - Light shadow on scroll

#### Quick Stats Card (Hero Section)
- **Circular Progress Ring** (120px diameter):
  - Outer ring: Water cyan fill (% of daily goal)
  - Center: Large number (e.g., "1.2L")
  - Subtitle: "of 2.5L today"
  - Tap to open quick log
  
- **Below Ring:**
  - Status message (dynamic):
    * "Great job! You're on track" (if >75%)
    * "You're halfway there! Keep going" (if 50-75%)
    * "Don't forget to hydrate" (if <50%)

#### Quick Action Buttons (Grid 2x2)
1. **Log Water** (Large blue button with water droplet icon)
   - Tap: Opens quick log modal
   
2. **View Buddy** (Shows first buddy avatar + "View")
   - Tap: Opens buddy dashboard
   
3. **Today's Challenge** (Shows challenge type icon)
   - Tap: Opens challenge details
   
4. **My Streak** (Shows flame icon + number)
   - Tap: Opens streaks page

#### Today's Water Logs (Card)
- **Title:** "Today's Logs"
- **Timeline View:**
  - Each log as horizontal bar: [Time] — [Amount] — [Delete icon]
  - Time format: "9:32 AM"
  - Amount: "500ml" or "2 cups"
  - Tap to edit time
  - Swipe left: Delete confirmation
  
- **Add Log Button:** Bottom of list

#### Buddy Streak Progress (If paired)
- **Card Title:** "You & [Buddy Name]"
- **Large Streak Number:** "7" with flame icon 🔥
- **Subtitle:** "days streaking together!"
- **Progress Bar:** "7 of 30 for next reward"
- **Next Milestone Badge:** "Unlock 'Squad' cosmetic at 14 days"
- **Buddy Status:** "They've logged 1.5L today ✓" (real-time)

#### This Week Challenge
- **Card Layout:**
  - Challenge icon + title (e.g., "Volume Hero")
  - Your progress: "1.8L / 3L this week"
  - Linear progress bar
  - Your rank: "12th place" (if leaderboard exists)
  - "View Leaderboard" link

#### XP & Level Progress
- **Card Layout:**
  - Level badge: "LEVEL 7" (large, 64px)
  - XP bar: [===== ] 650/1000 XP
  - "Next level: 350 XP to go"
  - Recent XP gain: "+50 XP (goal achieved)"

#### Motivational Section
- **Random tip or buddy fact:**
  - "Your buddy [Name] has been consistent for 10 days!"
  - "Drink 1L more to get the 'Hydration Squad' badge"
  - Rotate every day

#### Bottom Navigation Safe Area (56px)

**Interactions:**

1. **Log Water Button:**
   - Modal opens with quick buttons: 250ml, 500ml, 1L, custom
   - Custom: Input field for ml amount
   - On confirm: Ring animates, XP toast appears (+10 XP)
   - Auto-dismiss after 1.5s, return to home

2. **Buddy Card Tap:**
   - Navigate to Buddy tab with that buddy selected

3. **Challenge Card:**
   - Navigate to Challenges tab, scroll to today's challenge

4. **Settings Icon:**
   - Open drawer menu (hamburger)

**Real-time Updates:**
- If using Firestore listeners: Subscribe to today's logs, buddy updates
- On log update: Ring animates in real-time
- On buddy log: Show notification "Your buddy drank water! 💧"

**Empty States:**
- First launch (no logs yet): Show illustration + "Log your first glass of water"
- No buddy paired: Show "Add a buddy to stay accountable" card
- No challenge: Show "No active challenges" (unlikely)

---

## 2.3 Buddy Tab

### Screen: Buddy List
**Screen Name:** `BuddyListScreen`

**Layout:**

#### Header
- Title: "My Buddies"
- Subtitle: "You have 3 active buddies"
- Add Buddy Button (floating + / in top-right)

#### Buddy Cards (Vertical List)
Each card shows:
- Avatar (48x48px, circular)
- Name (18px, bold)
- Current progress ring (60px diameter, smaller version)
- "1.2L of 2.5L"
- Streak indicator: "7 🔥" (if streaking)
- Status badge: "Logged today ✓" or "Not logged yet"
- Three dots menu (more options: edit nickname, unbuddy, mute notifications)

**Tap on card:** Navigate to detailed buddy view

#### Pending Buddy Requests
- **Section Title:** "Pending Requests (2)"
- **Request Cards:**
  - Avatar + name + "Sent you a request"
  - Accept button (blue) | Decline button (gray)
  - On accept: Move to active buddies, notify requester
  - On decline: Remove from list, notify requester

#### Add Buddy Button
- FAB or bottom section button
- Opens **Add Buddy Modal** (see below)

---

### Screen: Detailed Buddy View
**Screen Name:** `BuddyDetailScreen`

**Parameters:** `buddyId` (String)

**Layout:**

#### Header Card
- Large avatar (96x96px)
- Name + pronouns (24px bold)
- Username (16px gray)
- "Paired since [Date]"

#### Buddy Streak Section
- **Large Streak Display:** "12" + flame icon 🔥
- **Subtitle:** "days streaking together"
- **Progress to next milestone:**
  - "14 days: Unlock 'Hydration Squad' cosmetic"
  - Progress bar: 12/14

#### Today's Progress
- **Circular Ring:** Buddy's current progress (same as home)
- **Status:** "Logged 1.2L today" or "Not logged yet"
- **Real-time feed:** Last logged at 9:32 AM + [amount]

#### Weekly Stats Comparison
- **Card Title:** "This Week (Mon-Sun)"
- **Table:**
  ```
  You:    [Ring] 15.2L
  Buddy:  [Ring] 14.8L
  ```
- **Winner badge:** "You're ahead by 0.4L!" or "Buddy is ahead!"

#### Challenge Progress
- **Card Title:** "[Current Challenge] Progress"
- **Your progress:** "1.8L"
- **Buddy progress:** "1.5L"
- **Comparison:** "You're 0.3L ahead"
- **Leaderboard rank:** "You're 8th, Buddy is 12th"

#### Interaction Buttons (Grid)
1. **Send Message** (icon: chat bubble)
   - Opens quick emoji/text reactions
   - Presets: "💪", "🔥", "Keep it up!", "You got this!"
   
2. **Nudge** (icon: notification bell)
   - Sends notification: "[Your Name] is nudging you to drink water!"
   - Cooldown: 1 per 2 hours
   
3. **Edit Nickname** (icon: pencil)
   - Opens modal with current nickname
   - Max 20 chars
   - On save: Updates everywhere in app

4. **Mute Notifications** (icon: bell-off)
   - Toggle: Mute / Unmute
   - Still see them in app, just no notifications

5. **Unbuddy** (icon: X, red color)
   - Confirmation modal: "Remove [Name] as buddy? You can re-add anytime."
   - On confirm: They're removed from list, can still request again

#### Chat/Feed Section (Bottom)
- **Quick Reactions Feed:**
  - Shows recent reactions/messages
  - Format: "[Your name] sent 🔥 at 3:42 PM"
  - Max 5 most recent shown

#### Bottom Action
- **"Send Buddy Request" (if pending)**
- **"You're buddies" (if active)** — with additional options

---

### Modal: Add Buddy
**Screen Name:** `AddBuddyModal`

**Layout:**

#### Tabs (Segmented Control)
1. **Search**
2. **Scan QR**
3. **Invite Link**

#### Search Tab Content
- **Input field:** "Search by username"
- **Real-time results:**
  - Avatar + username + mutual buddies count (e.g., "2 mutual")
  - Tap to view profile preview modal OR send request
- **Empty state:** "No results" with illustration

#### Scan QR Tab Content
- **Camera view with QR overlay**
- **On successful scan:** Show buddy info + confirm button
- **Flash toggle (top-right)**
- **Close button (top-left)**

#### Invite Link Tab Content
- **Your invite link:** `waterbros.app/buddy/USERID`
- **Copy to clipboard button**
- **Share button** (opens native share sheet)
- **Manage links:** Show previously sent links, can revoke

#### Action Buttons
- **Send Request** (blue button, appears on selection)
- **Cancel** (secondary button)

**Request States:**
- On submit: "Sent!" toast, user selected clears
- If already requested: Show "Request pending" state
- If already buddied: Show "Already buddies" state

---

## 2.4 Leaderboard Tab

### Screen: Leaderboard Hub
**Screen Name:** `LeaderboardScreen`

**Layout:**

#### Leaderboard Type Selector (Horizontal Scroll)
```
[Global] [Friends] [City] [XP]
```
- Segmented control or chip buttons
- Active = blue, inactive = gray
- Selected: Shows that leaderboard

#### Current User Highlight Card (Fixed Below Selector)
- Your rank badge: "12th" (large, 48px)
- Your name + avatar
- Your value: "1850 XP" (for XP board) or "15.2L" (for volume board)
- Comparison: "+50 XP from yesterday" or "+0.5L from last week"

#### Leaderboard List (Scrollable)
**Each user row:**
- Rank number (left): "1.", "2.", "3." (bold, 18px)
- Avatar (32x32px circular)
- Name (16px) + username gray (12px)
- Value (right, monospace, 16px)
  - "1950 XP" (XP board)
  - "18.5L" (Volume board)
- Crown icon (🏆) for top 3
- Highlight row if it's the current user (light blue background)

**Interactions:**
- Tap row: Open user profile modal (non-editable view)
- Infinite scroll: Load more as user scrolls (pagination)

#### Pull to Refresh
- Refresh icon + "Last updated 2 mins ago"
- Pull down to update leaderboard rankings

#### Empty States
- Friends board with no friends: "Add buddies to see a leaderboard"
  - Button: "Add Buddy"

#### Bottom Safe Area

---

### Modal: User Profile Preview
**Screen Name:** `UserProfileModal`

**Parameters:** `userId` (String)

**Content (Non-editable):**
- Avatar (96x96px)
- Name + username
- Bio (if available)
- Level badge + XP
- Stats:
  - Days streaking (if applicable)
  - Total water logged this week
  - Achievement badges (show 6 most recent)

**Action Buttons:**
- **Add Buddy** (if not already buddied)
- **View Profile** (if public) — opens full profile view
- **Close** (X icon)

---

## 2.5 Challenges Tab

### Screen: Challenges Hub
**Screen Name:** `ChallengesScreen`

**Layout:**

#### Section: This Week's Challenge (Pinned)
- **Large Challenge Card:**
  - Challenge icon (60x60px)
  - Title: "Hydration Hero" (24px bold)
  - Description: "Log 3L+ this week to win rewards"
  - Time remaining: "4 days, 12 hours left"
  - Your progress: "[===== ] 1.8L / 3L"
  - Participants: "247 people competing"
  - "View Leaderboard" button
  - Status: "In Progress" or "Completed" badge
  - Join/Leave button (if not joined)

#### Section: Your Active Challenges
- **Cards in grid (2 per row):**
  - Each shows: Icon, title, time left, progress bar, participation count
  - Joined challenges highlighted with checkmark
  - Tap to expand details

#### Section: All Available Challenges
- **Show 5 upcoming, scroll for more:**
  - Challenge type badge (e.g., "SPEED", "CONSISTENCY")
  - Title + description (2 lines)
  - Start/end dates
  - Participants count
  - Join button

#### Filter Chips (Optional)
- All / Active / Completed / Upcoming
- Helps users navigate challenge history

---

### Screen: Challenge Details
**Screen Name:** `ChallengeDetailScreen`

**Parameters:** `challengeId` (String)

**Layout:**

#### Header Section
- Challenge icon (96x96px)
- Title (28px bold)
- Status badge: "Active" / "Upcoming" / "Completed"
- Description (body text, full description)
- Dates: "June 17 - June 24"

#### Challenge Rules Card
- **Rules (read-only text):**
  ```
  • Log water intake daily
  • Earn points based on volume logged
  • Top 10 win exclusive cosmetics
  • Leaderboard updates in real-time
  ```

#### Your Progress Section
- **Large progress bar:** Your % progress
- **Stats grid:**
  - Your value: "1.8L"
  - Goal: "3L"
  - Your rank: "12th place"
  - Participants: "247"

#### Leaderboard (Top 10)
- Same as main leaderboard but filtered to this challenge
- Highlight your position
- Infinite scroll for full leaderboard

#### Action Buttons
- **Join Challenge** (if not joined, blue button)
- **Leave Challenge** (if joined, secondary button)
- On join: "Welcome! Start logging water to earn points" toast
- On leave: "You've left the challenge" confirmation

---

## 2.6 Profile / Settings

### Screen: My Profile
**Screen Name:** `MyProfileScreen`

**Layout:**

#### Profile Header
- **Avatar:** 96x96px, circular, tap to change (camera + gallery picker)
- **Name:** 24px bold, tap to edit
- **Username:** 14px gray, @username
- **Bio:** 14px, 2 lines max, tap to edit
- **Pronouns:** [He/Him] — tap to edit

#### Quick Stats
- **Card grid (2 per row):**
  1. **Level:** Large badge showing "7" + "LEVEL 7"
  2. **Total XP:** "2,450 XP" (monospace)
  3. **Water This Week:** "12.5L"
  4. **Longest Streak:** "12 days" 🔥

#### Achievements & Badges
- **Title:** "Achievements (18 unlocked)"
- **Grid (4 per row):**
  - Each badge: 48x48px square with icon
  - Tooltip on hover/long-press: Badge name + unlock date
  - Scroll to see all
  - Locked badges shown as gray placeholders with lock icon
  - "9 more to unlock" indicator

#### Recent Cosmetics
- **Title:** "Your Cosmetics"
- **Active cosmetic showcase:**
  - **Cup Skin:** Shows preview of water ring with current skin
  - **App Theme:** Shows light/dark toggle with preview
  - **Avatar Border:** Shows avatar with current border
  - **Emotes:** Shows 3 favorite quick-react emotes
- **"View All" link:** Opens cosmetics inventory

#### Settings Section
- **Settings Icon + "Settings"** (navigates to settings screen)

#### Bottom Actions
- **"Edit Profile" button** (pencil icon)
- Opens edit modal with all editable fields

---

### Screen: Settings
**Screen Name:** `SettingsScreen`

**Layout:**

#### Account Section
- **Change Password:** Tap → modal with current + new password
- **Email:** your@email.com → tap to change
- **Delete Account:** Danger button (red)
  - Opens confirmation: "Are you sure? All data will be deleted."
  - Requires password confirmation

#### Notifications
- **Title:** "Notifications"
- **Toggles:**
  - Hydration reminders (on/off)
    - If on, show: Time picker for first/last reminders (e.g., 9 AM - 8 PM)
    - Frequency: Every 2 hours / Custom times (radio buttons)
  - Buddy notifications (on/off)
    - Disable: Buddy logs, buddy streaks, buddy messages
  - Challenge notifications (on/off)
  - Leaderboard updates (on/off)
    - Disable: Rank changes, friends leaderboard changes
  - Achievement notifications (on/off)
  - Level up notifications (on/off)

#### Health & Privacy
- **Title:** "Health & Privacy"
- **Daily Goal:** Current value, tap to change (modal with input)
  - Show formula explanation
- **Activity Level:** Current (Moderate), tap to change (radio buttons)
- **Climate Region:** Current (Temperate), tap to change (dropdown)
- **Profile Visibility:** 
  - Public / Friends Only / Private (radio)
  - Shows leaderboard visibility note
- **Special Conditions:** (checkboxes, optional)
  - Pregnant/Breastfeeding
  - Medical condition
- **Data Export:** Button to export all personal data (GDPR)

#### Integrations (Phase 2)
- **Apple Health:** Toggle on/off + permissions status
- **Google Fit:** Toggle on/off + permissions status
- **Wearable Apps:** (after Phase 2 launch)

#### Appearance
- **Dark Mode:** System / Light / Dark (radio buttons)
- **Font Size:** Small / Medium / Large (radio)
- **Accessibility:**
  - Reduce motion (toggle)
  - High contrast mode (toggle)
  - Screen reader support (toggle)

#### About
- **App Version:** "1.0.0" + "Check for Updates" button
- **Terms of Service:** Link (opens in-app webview)
- **Privacy Policy:** Link (opens in-app webview)
- **Support:** Email button → open email app pre-filled with support email
- **Feedback:** Button → Google Form or Typeform widget

#### Sign Out
- **"Sign Out" button** (red text, bottom of screen)
- Confirmation: "Sign out? Your data will remain in your account."
- On confirm: Navigate to login screen

---

## 2.7 Drawer / Hamburger Menu

### Drawer Content
**Screen Name:** `AppDrawer`

**Layout (From Top):**
- Current user card:
  - Avatar (48x48px)
  - Name (18px bold)
  - Username (14px gray)
  - Level badge (small, 24x24px)
  - Tap to open profile

- **Menu Items:**
  1. Home (icon: house)
  2. Buddies (icon: people, with badge showing pending requests count)
  3. Leaderboard (icon: podium)
  4. Challenges (icon: target)
  5. Profile (icon: person-circle)
  6. Settings (icon: gear)
  7. Divider
  8. Support (icon: question-circle)
  9. Feedback (icon: message-square)
  10. Sign Out (icon: sign-out, red text)

**Interactions:**
- Tap item: Navigate to screen, close drawer
- User card tap: Open profile, close drawer
- Swipe left or tap background: Close drawer

---

# PART 3: USER FLOWS & WIREFRAME DESCRIPTIONS

## 3.1 Core User Flows

### Flow 1: First-Time User (Onboarding to Home)
```
1. App launch
   → Splash screen (logo, 1.5s)
   → Check if authenticated (AsyncStorage)
   
2a. Not authenticated → Welcome screen
    → Sign up / Log in
    → Create account (email/password or Google/Apple)
    → Firebase Auth (client-side validation)
    
2b. Authenticated but incomplete profile → Profile setup
    → Fill avatar, username, health data
    → POST /users/{userId}/profile
    
3. Complete profile
   → Onboarding: Add first buddy (optional)
   → Onboarding: Request notification permissions
   → Home screen (first-time: no logs, show empty state)
```

### Flow 2: Logging Water
```
1. Home screen
   → Tap "Log Water" button
   
2. Quick log modal
   → Tap: 250ml / 500ml / 1L / Custom
   
3. Custom logic:
   - Quick amounts: Create log immediately
   - Custom: Show input field, confirm button
   
4. On confirm:
   → POST /logs
   → On success:
      - Close modal
      - Animate progress ring (500ml, 800ms)
      - Show toast: "+10 XP" (auto-dismiss 2.5s)
      - Refresh logs list
      - Check if daily goal reached (trigger animation)
      - Update buddy if applicable
      - Real-time listener updates buddy view
```

### Flow 3: Adding a Buddy
```
1. Multiple entry points:
   - Onboarding "Add buddy" screen
   - Buddy tab: "Add Buddy" button
   - Direct link: Share code or QR
   
2. Search method:
   → Input username
   → Real-time search (debounced 300ms)
   → Show results (avatar + name + mutual count)
   → Tap user → Send request button
   → POST /buddies/request
   
3. QR scan method:
   → Open camera
   → Scan QR (buddy's unique code)
   → Show buddy info
   → Confirm send request
   → POST /buddies/request
   
4. Invite link method:
   → Share link (copy or native share)
   → Recipient clicks link
   → Opens app with `?buddy=CODE`
   → Accept automatically or confirm
   
5. Request state:
   → On send: "Request sent!" toast
   → Recipient gets notification + can accept/decline
   → On accept: Both notified, buddy appears in list
   → Mutual buddy streak initialized at 0
```

### Flow 4: Competing in a Challenge
```
1. Challenges tab
   → View active/upcoming challenges
   → Tap challenge card
   
2. Challenge details
   → View rules, participants, leaderboard
   → Tap "Join Challenge" (if not joined)
   → POST /challenges/{id}/join
   
3. On join:
   → "Welcome to [Challenge]!" toast
   → Challenge status: "In Progress"
   → Your logs now count toward challenge
   → Leaderboard updates in real-time
   
4. Logging during challenge:
   → Each log increments challenge progress
   → Real-time leaderboard update (Firestore listener)
   → Your rank may change
   → Notification if you reach top 10
   
5. Challenge end:
   → Countdown timer shows 0
   → Challenge status: "Completed"
   → Final results shown
   → Rewards distributed (cosmetics/XP)
   → Can view final leaderboard
```

### Flow 5: Viewing Real-Time Buddy Activity
```
1. Buddy detail screen
   → Firestore listener subscribed to buddy logs
   → Listener triggers on new log
   
2. On buddy log (real-time):
   → Buddy's progress ring updates (animated)
   → Status updates: "Logged 1.5L at 3:42 PM"
   → If they complete goal:
      - Notification: "[Buddy] just reached their goal! 🎉"
      - Celebratory animation
      - Streak updated if applicable
   
3. User can:
   → Send quick reaction: 💪, 🔥, Keep it up!
   → Send nudge: Notification reminder
   → View buddy's detailed logs
```

---

## 3.2 Detailed Wireframe Descriptions

### Wireframe: Home Screen Layout
```
┌─────────────────────────────┐
│ ☰  WaterBros          ⚙️    │  Header (sticky)
├─────────────────────────────┤
│                             │
│        [Circular Ring]      │  Quick stats hero
│        1.2L / 2.5L          │
│   "Great job! Keep going"   │
│                             │
├─────────────────────────────┤
│ [Log Water] [Buddy] [Chall] │  Quick actions (2x2 grid)
│ [Streak]   [ - ]   [ - ]    │
├─────────────────────────────┤
│ TODAY'S LOGS                │  Logs timeline
│ 9:32 AM    500ml     [×]    │
│ 12:15 PM   1L        [×]    │
│ 3:42 PM    500ml     [×]    │
│ [+ Log water]               │
├─────────────────────────────┤
│ YOU & JOHN (Buddy Streak)   │  Buddy section
│ 7 🔥 days streaking!        │
│ [=====>  ] 7/14 for reward  │
│ John logged 1.5L today ✓    │
├─────────────────────────────┤
│ HYDRATION HERO (Challenge)  │  Challenge card
│ Your: [===> ] 1.8L / 3L     │
│ 12th place • 247 competing  │
│ [View Leaderboard]          │
├─────────────────────────────┤
│ LEVEL 7              [XP]   │  XP progress
│ [========> ] 650 / 1000     │
│ +50 XP (goal achieved)      │
├─────────────────────────────┤
│   [Home] [Buddy] [Board]    │  Tab bar (bottom)
│   [Chall] [Profile]         │
└─────────────────────────────┘
```

### Wireframe: Buddy Detail Screen
```
┌─────────────────────────────┐
│ <    Buddy Details      [•••]│  Header
├─────────────────────────────┤
│                             │
│      [Avatar]               │  Buddy info
│      John Smith             │
│      @johnsmith             │
│                             │
├─────────────────────────────┤
│ 7 🔥 DAYS STREAKING         │  Buddy streak
│ together!                   │
│ [=======> ] 7/14 next reward│
│                             │
├─────────────────────────────┤
│        [Ring]               │  Buddy progress
│        1.2L / 2.5L          │
│   Logged today ✓            │
│                             │
├─────────────────────────────┤
│ THIS WEEK                   │  Weekly comparison
│ You:   [Ring] 15.2L         │
│ John:  [Ring] 14.8L         │
│ You're ahead by 0.4L!       │
├─────────────────────────────┤
│ [Chat] [Nudge] [Edit] [Mute]│  Interaction buttons
│ [Unbuddy]                   │
├─────────────────────────────┤
│ QUICK REACTIONS             │  Chat feed
│ You sent 🔥 at 3:42 PM     │
│ John sent 💪 at 2:15 PM    │
│ You sent "Keep it up!"      │
├─────────────────────────────┤
│ ☰ (drawer)  [Buddy] [Board] │  Nav
└─────────────────────────────┘
```

---

# PART 4: TECHNICAL ARCHITECTURE

## 4.1 System Overview

```
┌─────────────────┐
│  Flutter Client │ (iOS + Android)
├─────────────────┤
│  Firebase Auth  │ (Authentication)
│  Firestore DB   │ (Real-time data)
│  Cloud Functions│ (Backend logic)
│  Cloud Storage  │ (User avatars, assets)
│  FCM            │ (Push notifications)
│  Analytics      │ (Event tracking)
└─────────────────┘
     │
     ├─ REST API (Custom endpoints, if needed)
     ├─ Stripe (Payments, Phase 2)
     └─ Third-party APIs (Apple Health, Google Fit - Phase 2)
```

## 4.2 State Management Architecture

**Framework:** Riverpod (recommended for Flutter)

### State Providers
```dart
// Auth
Provider<AuthState> authStateProvider
Provider<User?> currentUserProvider
NotifierProvider<AuthNotifier, AuthState> authNotifierProvider

// User Profile
FutureProvider<UserProfile> userProfileProvider
NotifierProvider<ProfileNotifier, UserProfile> profileNotifierProvider

// Water Logs
StreamProvider<List<WaterLog>> todayLogsProvider
NotifierProvider<LogsNotifier, List<WaterLog>> logsNotifierProvider

// Buddies
StreamProvider<List<Buddy>> buddiesProvider
FutureProvider<Buddy> buddyDetailProvider(String buddyId)
NotifierProvider<BuddyNotifier, BuddyState> buddyNotifierProvider

// Leaderboard
FutureProvider<List<LeaderboardUser>> leaderboardProvider(String type)
StreamProvider<List<LeaderboardUser>> realtimeLeaderboardProvider(String type)

// Challenges
FutureProvider<List<Challenge>> activeChallengesProvider
StreamProvider<Challenge> currentWeekChallengeProvider
NotifierProvider<ChallengeNotifier, ChallengeState> challengeNotifierProvider

// XP & Level
Provider<int> currentLevelProvider(int totalXp)
Provider<int> nextLevelXpProvider(int currentLevel)
```

## 4.3 Firebase Configuration

### Authentication Methods
```
1. Email/Password: Firebase Authentication
2. Google Sign-In: Firebase Auth provider
3. Apple Sign-In: Firebase Auth provider
4. Anonymous: Optional for testing

Session:
- Token stored in Secure Storage (flutter_secure_storage)
- Auto-refresh using Firebase's built-in token management
- Logout clears token + local user data
```

### Firestore Database Structure
**(See Section 6: Database Schema)**

### Cloud Functions (Node.js)
- Trigger on document write (logs, challenges, leaderboards)
- Calculate XP, check goal completion, update leaderboards
- Send notifications (FCM)
- Enforce game logic (prevent tampering)

### Cloud Storage
- Path: `/avatars/{userId}/{filename}`
- Max file size: 5MB
- Formats: JPEG, PNG (convert to WebP on backend)

### FCM Configuration
- Topic subscriptions: Per challenge, per buddy
- Message payload: 4KB max, includes action data
- Android: High priority, notification channel
- iOS: Alert + sound + badge

## 4.4 API Design (REST Endpoints)

**Base URL:** `https://api.waterbros.app/v1`

### Authentication Endpoints
```
POST /auth/signup
  Body: { email, password, deviceId }
  Response: { token, user }

POST /auth/login
  Body: { email, password, deviceId }
  Response: { token, user }

POST /auth/refresh
  Headers: { Authorization: Bearer <token> }
  Response: { token }

POST /auth/logout
  Headers: { Authorization: Bearer <token> }
  Response: { success }
```

### User Endpoints
```
GET /users/me
  Headers: { Authorization: Bearer <token> }
  Response: { user: UserProfile }

PUT /users/me
  Headers: { Authorization: Bearer <token> }
  Body: { name, bio, pronouns, activityLevel, climate }
  Response: { user: UserProfile }

PUT /users/me/avatar
  Headers: { Authorization: Bearer <token> }
  Body: FormData with image
  Response: { avatarUrl }

PUT /users/me/goal
  Headers: { Authorization: Bearer <token> }
  Body: { dailyGoalMl: number }
  Response: { dailyGoal }

PUT /users/me/settings
  Headers: { Authorization: Bearer <token> }
  Body: { notificationsEnabled, theme, fontSize, ... }
  Response: { settings }
```

### Water Log Endpoints
```
POST /logs
  Headers: { Authorization: Bearer <token> }
  Body: { amountMl: number, timestamp: ISO8601 }
  Response: { log: WaterLog, xpEarned: number, leveledUp: boolean }

GET /logs/today
  Headers: { Authorization: Bearer <token> }
  Response: { logs: WaterLog[], totalMl: number, goalMl: number }

GET /logs?startDate=YYYY-MM-DD&endDate=YYYY-MM-DD
  Headers: { Authorization: Bearer <token> }
  Response: { logs: WaterLog[] }

PUT /logs/{logId}
  Headers: { Authorization: Bearer <token> }
  Body: { amountMl: number, timestamp: ISO8601 }
  Response: { log: WaterLog }

DELETE /logs/{logId}
  Headers: { Authorization: Bearer <token> }
  Response: { success }
```

### Buddy Endpoints
```
POST /buddies/request
  Headers: { Authorization: Bearer <token> }
  Body: { targetUserId: string } OR { username: string }
  Response: { request: BuddyRequest }

GET /buddies
  Headers: { Authorization: Bearer <token> }
  Response: { buddies: Buddy[], pending: BuddyRequest[] }

GET /buddies/{buddyId}
  Headers: { Authorization: Bearer <token> }
  Response: { buddy: Buddy, stats: BuddyStats }

PUT /buddies/{buddyId}
  Headers: { Authorization: Bearer <token> }
  Body: { nickname: string, notifications: boolean }
  Response: { buddy: Buddy }

POST /buddies/{buddyId}/request/accept
  Headers: { Authorization: Bearer <token> }
  Response: { buddy: Buddy, streak: StreakInitialized }

POST /buddies/{buddyId}/request/decline
  Headers: { Authorization: Bearer <token> }
  Response: { success }

DELETE /buddies/{buddyId}
  Headers: { Authorization: Bearer <token> }
  Response: { success }

POST /buddies/{buddyId}/message
  Headers: { Authorization: Bearer <token> }
  Body: { type: 'emoji'|'text', content: string }
  Response: { message: Message }

POST /buddies/{buddyId}/nudge
  Headers: { Authorization: Bearer <token> }
  Response: { notificationSent: boolean }
```

### Challenge Endpoints
```
GET /challenges
  Query: { status: 'active'|'upcoming'|'completed', page: number }
  Response: { challenges: Challenge[], total: number }

GET /challenges/{challengeId}
  Response: { challenge: Challenge, leaderboard: LeaderboardUser[] }

POST /challenges/{challengeId}/join
  Headers: { Authorization: Bearer <token> }
  Response: { participation: ChallengeParticipation }

DELETE /challenges/{challengeId}/leave
  Headers: { Authorization: Bearer <token> }
  Response: { success }

GET /challenges/{challengeId}/leaderboard
  Query: { page: number, limit: number }
  Response: { leaderboard: LeaderboardUser[], yourRank: number, totalParticipants: number }
```

### Leaderboard Endpoints
```
GET /leaderboards/{type}
  Query: { page: number, limit: number, period: 'week'|'month'|'allTime' }
  Headers: { Authorization: Bearer <token> (optional) }
  Response: { leaderboard: LeaderboardUser[], yourRank: number, totalUsers: number }

Leaderboard types:
  - /leaderboards/global — All users
  - /leaderboards/friends — User's buddies
  - /leaderboards/city — Users in same city (if location shared)
  - /leaderboards/xp — XP rankings (leaderboards/{type}?metric=xp)
  - /leaderboards/weekly — This week's volume
  - /leaderboards/challenges/{challengeId} — Challenge-specific
```

### Profile Endpoints
```
GET /users/{userId}/profile
  Response: { user: PublicUserProfile, stats: UserStats, achievements: Achievement[] }

GET /users/{userId}/leaderboard-position
  Response: { globalRank: number, friendsRank: number, xpRank: number }
```

## 4.5 Error Handling Strategy

### HTTP Status Codes
```
200 OK - Success
201 Created - Resource created
204 No Content - Success, no body
400 Bad Request - Validation error
401 Unauthorized - Missing/invalid token
403 Forbidden - User lacks permission
404 Not Found - Resource not found
409 Conflict - Duplicate (e.g., already buddied)
429 Too Many Requests - Rate limited
500 Internal Server Error - Server error
503 Service Unavailable - Temporarily down
```

### Error Response Format
```json
{
  "error": {
    "code": "EMAIL_IN_USE",
    "message": "Email address already registered",
    "details": "Use 'login' endpoint instead",
    "userMessage": "This email is already in use. Did you mean to sign in?"
  }
}
```

### Client-Side Retry Logic
- Exponential backoff: 1s, 2s, 4s, 8s max
- Max retries: 3
- Don't retry: 4xx errors (except 429), 401

---

# PART 5: DATABASE SCHEMA & MODELS

## 5.1 Firestore Collections

### Collection: `users`
```javascript
{
  uid: string,                    // Primary key (Firebase Auth UID)
  email: string,
  username: string,
  displayName: string,
  bio: string (nullable),
  pronouns: string,               // 'He/Him', 'She/Her', 'They/Them', 'Custom'
  avatarUrl: string,
  
  // Profile settings
  activityLevel: 'sedentary' | 'light' | 'moderate' | 'intense',
  climate: 'cold' | 'temperate' | 'hot' | 'tropical',
  specialConditions: string[],    // 'pregnant', 'breastfeeding', 'medical_condition'
  dailyGoalMl: number,
  
  // Stats
  totalXp: number,
  level: number,                  // Calculated: level = floor(totalXp / 1000)
  longestStreakDays: number,
  currentStreakDays: number,
  
  // Preferences
  settings: {
    notificationsEnabled: boolean,
    remindersHours: [9, 12, 15, 18],  // 24-hour format
    darkMode: 'system' | 'light' | 'dark',
    fontSize: 'small' | 'medium' | 'large',
  },
  
  // Privacy
  profileVisibility: 'public' | 'friends_only' | 'private',
  createdAt: timestamp,
  updatedAt: timestamp,
  lastLoginAt: timestamp,
  
  // Cosmetics
  equippedCosmetics: {
    cupSkin: string,              // 'default', 'ocean', 'forest', etc.
    appTheme: string,             // 'default_light', 'default_dark', etc.
    avatarBorder: string,
    emotes: string[],             // Max 3 favorite emotes
  }
}
```

### Collection: `logs`
```javascript
{
  docId: string,                  // Auto-generated Firestore ID
  userId: string,                 // Foreign key to users
  amountMl: number,
  timestamp: timestamp,           // When the water was logged (nullable, defaults to now)
  createdAt: timestamp,           // When log was created in app
  
  // Optional fields
  beverageType: string,           // 'water', 'coffee', 'tea', 'juice', 'other'
  location: string (nullable),    // For 'location' achievement
  
  // Metadata
  deviceId: string,               // For duplicate detection
  synced: boolean,
  
  // Calculated
  xpAwarded: number,              // Base 10 XP
}
```

### Collection: `buddies`
```javascript
{
  docId: string,                  // Format: `{userId1}_{userId2}` (alphabetically sorted)
  user1Id: string,                // Alphabetically first
  user2Id: string,                // Alphabetically second
  
  // Relationship
  status: 'pending' | 'active' | 'declined',
  requestInitiatedBy: string,     // Which user sent request
  
  // Streaks
  streakDays: number,             // Days both hit 80%+ goal
  streakStartDate: timestamp,
  longestStreakDays: number,
  
  // Customization
  user1Nickname: string (nullable),
  user2Nickname: string (nullable),
  
  // Preferences
  user1NotificationsEnabled: boolean,
  user2NotificationsEnabled: boolean,
  
  // Metadata
  createdAt: timestamp,
  acceptedAt: timestamp (nullable),
  declinedAt: timestamp (nullable),
  unbuddiedAt: timestamp (nullable),
}
```

### Collection: `dailyGoals`
```javascript
{
  docId: string,                  // Format: `{userId}_{YYYY-MM-DD}`
  userId: string,
  date: string,                   // YYYY-MM-DD
  
  goalMl: number,                 // User's goal for this day
  completedMl: number,            // Total logged
  percentComplete: number,        // Calculated: completedMl / goalMl * 100
  completed: boolean,             // >= 80% = true
  
  // Streaks
  streakContinued: boolean,       // Did user maintain streak today?
  currentStreak: number,          // Streak count on this day
  
  // XP
  xpEarned: number,               // Sum of log XPs for the day
  goalBonusXp: number,            // 50 XP if goal completed
  
  createdAt: timestamp,
  updatedAt: timestamp,
}
```

### Collection: `challenges`
```javascript
{
  docId: string,                  // Auto-generated
  title: string,
  description: string,
  type: 'volume' | 'consistency' | 'speed' | 'group' | 'multiplier',
  
  // Timeline
  startDate: timestamp,
  endDate: timestamp,
  
  // Rules
  rules: {
    minVolume: number,            // For volume challenges
    multiplier: number,           // For multiplier challenges (default 1.0)
    requireDailyLogging: boolean, // For consistency challenges
  },
  
  // Metadata
  status: 'draft' | 'upcoming' | 'active' | 'completed',
  participantCount: number,       // Updated in real-time
  
  // Rewards
  rewards: {
    top1Cosmetic: string,
    top10Xp: number,
    participantXp: number,
  },
  
  // Filtering
  tags: string[],                 // ['recurring', 'weekly', 'seasonal']
  createdAt: timestamp,
}
```

### Collection: `challengeParticipations`
```javascript
{
  docId: string,                  // Format: `{userId}_{challengeId}`
  userId: string,
  challengeId: string,
  
  // Progress
  volumeLogged: number,
  currentRank: number,
  
  // Reward status
  rewardClaimed: boolean,
  
  // Metadata
  joinedAt: timestamp,
  leftAt: timestamp (nullable),
}
```

### Collection: `leaderboards`
```javascript
{
  docId: string,                  // Format: `{type}_{period}`
  type: 'global' | 'friends' | 'city' | 'xp',
  period: 'week' | 'month' | 'allTime',
  
  // Computed in Cloud Function
  rankings: [{
    userId: string,
    displayName: string,
    avatarUrl: string,
    xp: number,
    rank: number,
    change: number,               // Rank change from previous period
  }],
  
  // Metadata
  computedAt: timestamp,
}
```

### Collection: `achievements`
```javascript
{
  docId: string,                  // Format: `{userId}_{badgeId}`
  userId: string,
  badgeId: string,               // 'first_100ml', '7_day_streak', etc.
  
  badgeType: string,
  badgeTitle: string,
  badgeDescription: string,
  badgeIconUrl: string,
  
  unlockedAt: timestamp,
  rarity: 'common' | 'rare' | 'epic' | 'legendary',
}
```

### Collection: `cosmetics` (Reference/Inventory)
```javascript
{
  docId: string,                  // e.g., 'skin_ocean_blue'
  type: 'cup_skin' | 'app_theme' | 'avatar_border' | 'emote',
  
  name: string,
  description: string,
  previewUrl: string,
  
  // Acquisition
  unlockMethod: 'level' | 'achievement' | 'challenge_reward' | 'shop',
  unlockValue: number | string,   // Level 5, or 'first_100ml' achievement
  
  // Shop pricing (if applicable)
  shopPrice: number (nullable),   // Cosmetic coins
  shopRarity: 'common' | 'rare' | 'epic' | 'legendary',
  
  createdAt: timestamp,
}
```

### Collection: `squads` (Future, Phase 2)
```javascript
{
  docId: string,
  createdBy: string,
  name: string,
  description: string (nullable),
  
  members: [{
    userId: string,
    joinedAt: timestamp,
    role: 'creator' | 'member',
  }],
  
  // Squad goals
  weeklyGoal: number,            // ML to collectively log
  weeklyProgress: number,        // Calculated
  
  settings: {
    visibility: 'public' | 'private',
    allowInvites: boolean,
  },
  
  createdAt: timestamp,
}
```

---

# PART 6: ANALYTICS & EVENT TRACKING

## 6.1 Firebase Analytics Events

**Events to track:**

```
App Lifecycle:
- app_launch
- session_start
- session_end (duration in minutes)
- app_crash

Authentication:
- sign_up (method: email, google, apple)
- login (method: email, google, apple)
- logout
- password_reset

Water Logging:
- water_logged (amount_ml, log_type: quick_action|custom)
- daily_goal_reached
- daily_goal_missed
- log_edited
- log_deleted

Buddy System:
- buddy_request_sent (request_type: search|qr|link)
- buddy_request_accepted
- buddy_request_declined
- buddy_removed
- buddy_message_sent (message_type: emoji|text|nudge)
- buddy_streak_milestone (streak_days: 7|14|30)

Challenges:
- challenge_joined
- challenge_completed
- challenge_left
- challenge_rank_achieved (rank: 1|2-10|11-50)

Leaderboard:
- leaderboard_viewed (type: global|friends|city|xp)
- leaderboard_rank_achievement (rank: 1|2-10|11-100)

Gamification:
- level_up (new_level)
- achievement_unlocked (badge_id)
- cosmetic_unlocked (cosmetic_id)
- cosmetic_equipped (cosmetic_id)
- cosmetic_shop_viewed
- cosmetic_purchased (cosmetic_id)

Notifications:
- notification_received (type: reminder|buddy|challenge|achievement)
- notification_opened (type: ...)
- notification_dismissed

Engagement:
- feature_viewed (feature: profile|settings|leaderboard)
- settings_changed (setting_name, old_value, new_value)
- help_opened
- feedback_submitted

Retention:
- d1_retention (check: user_returned_day_1)
- d7_retention
- d30_retention
```

**Event properties to include:**
```
- user_id (anonymized)
- session_id
- timestamp
- platform (iOS/Android)
- app_version
- os_version
- user_properties: { level, total_xp, buddy_count, ... }
```

## 6.2 Custom Analytics Dashboard

**Build simple dashboards in Firebase Console for:**
1. DAU / MAU trends
2. Sign-up funnel
3. Buddy pairing rate
4. Challenge participation
5. Retention curves (D1, D7, D30, D30 cohorts)
6. Feature adoption (% users who viewed each major feature)
7. Leaderboard engagement (% users who check leaderboard)
8. Churn signals (identify users at risk)

---

# PART 7: AUTHENTICATION & SECURITY

## 7.1 Authentication Flow

**Supported Methods:**
1. Email/Password (Firebase)
2. Google Sign-In
3. Apple Sign-In
4. Anonymous (optional, for testing)

**Token Management:**
```
- Firebase handles JWT token issuance
- Token stored in flutter_secure_storage (encrypted)
- Auto-refresh on expiry (Firebase SDK handles)
- Logout: Clear token + local user data
- Session timeout: 30 days (optional manual logout)
```

**Two-Factor Authentication (Optional, Phase 2):**
- SMS OTP on login
- TOTP app support

## 7.2 Security Best Practices

**Client-Side:**
- Never log sensitive data (passwords, tokens)
- Validate all inputs (email format, password strength)
- Use HTTPS only for API calls
- Implement certificate pinning (optional)
- Obfuscate code (flutter build --obfuscate)

**Server-Side (Cloud Functions):**
- Validate Firebase Auth tokens
- Implement rate limiting (max 10 requests/minute per user)
- Validate all input data (server-side, don't trust client)
- Implement CSRF protection
- Log security events

**Data Privacy:**
- GDPR compliance: Data export, deletion
- PII handling: Only store necessary data
- No third-party tracking (GA only)
- Transparent privacy policy

**Database Security:**
- Firestore rules (see below)
- No direct database access from client (all via Cloud Functions)
- Audit logging for sensitive operations

## 7.3 Firestore Security Rules

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own document
    match /users/{userId} {
      allow read: if request.auth.uid == userId || 
                     get(/databases/$(database)/documents/users/$(userId)).data.profileVisibility == 'public';
      allow write: if request.auth.uid == userId;
      allow delete: if request.auth.uid == userId;
    }
    
    // Logs: Users can only read/write their own
    match /logs/{logId} {
      allow read: if resource.data.userId == request.auth.uid;
      allow create: if request.auth.uid == request.resource.data.userId;
      allow update, delete: if resource.data.userId == request.auth.uid;
    }
    
    // Buddies: Users can read/write relationships they're part of
    match /buddies/{buddyId} {
      allow read: if resource.data.user1Id == request.auth.uid || 
                     resource.data.user2Id == request.auth.uid;
      allow write: if (resource.data.user1Id == request.auth.uid || 
                       resource.data.user2Id == request.auth.uid) &&
                      request.resource.data.status in ['active', 'pending'];
    }
    
    // Challenges: Public read, users can write participation
    match /challenges/{challengeId} {
      allow read;
      match /participations/{partId} {
        allow read: if resource.data.userId == request.auth.uid;
        allow write: if resource.data.userId == request.auth.uid;
      }
    }
    
    // Leaderboards: Public read
    match /leaderboards/{boardId} {
      allow read;
    }
    
    // Achievements: Users can only read their own
    match /achievements/{achievementId} {
      allow read: if resource.data.userId == request.auth.uid;
    }
  }
}
```

---

# PART 8: TESTING & QA CHECKLIST

## 8.1 Unit Tests

**Coverage target:** 70%+

**Test suites:**
```
models_test.dart
  - User model serialization/deserialization
  - WaterLog calculation of XP
  - Buddy streak logic
  - Challenge participation state
  
providers_test.dart
  - Auth state transitions
  - User profile state updates
  - Logs state mutations
  - Buddy state synchronization
  
utils_test.dart
  - Date calculations (week, month)
  - XP calculation formula
  - Level calculation
  - Goal adjustment logic (climate, activity)
```

## 8.2 Widget Tests (UI Tests)

**Coverage target:** 40%+

```
home_screen_test.dart
  - Progress ring displays correctly
  - Water log buttons appear
  - Buddy streak shows
  - Challenge card displays
  
auth_screen_test.dart
  - Email/password inputs accept text
  - Google sign-in button present
  - Error messages display
  - Password validation shows in real-time
  
water_log_modal_test.dart
  - Quick log buttons work
  - Custom amount input works
  - Confirm adds log successfully
  
buddy_detail_screen_test.dart
  - Buddy info displays
  - Interaction buttons functional
  - Real-time updates trigger
```

## 8.3 Integration Tests

```
auth_flow_test.dart
  - Sign up → profile setup → home (happy path)
  - Login → home
  - Sign out → login screen
  
water_log_flow_test.dart
  - Log water → ring updates → XP shown
  - Multiple logs → totals correct
  - Edit log → data syncs
  
buddy_flow_test.dart
  - Send buddy request → notification → accept
  - Buddy logs water → notify user → real-time update
  - Streak maintained across days
  
challenge_flow_test.dart
  - Join challenge → appear in participants
  - Log water → leaderboard updates
  - Reach top 10 → notification sent
```

## 8.4 Manual QA Checklist

### Authentication
- [ ] Sign up with email
- [ ] Sign up with Google (iOS)
- [ ] Sign up with Apple (iOS)
- [ ] Log in with existing email
- [ ] Password reset flow
- [ ] Logout and log in again
- [ ] Token refresh (leave app, return after 1 hour)

### Water Logging
- [ ] Quick log 250ml
- [ ] Quick log 500ml
- [ ] Quick log 1L
- [ ] Custom log (custom amount)
- [ ] Log with past timestamp
- [ ] Edit log (change amount)
- [ ] Delete log (swipe left)
- [ ] Daily goal reached animation
- [ ] Ring updates in real-time
- [ ] XP toast appears (+10 XP)
- [ ] No duplicate logs on network error
- [ ] Offline logging (queue and sync later)

### Buddy System
- [ ] Add buddy by search
- [ ] Add buddy by QR scan
- [ ] Get invited via link
- [ ] Send buddy request
- [ ] Receive buddy request notification
- [ ] Accept buddy request
- [ ] Decline buddy request
- [ ] Buddy streak initializes at 0
- [ ] Buddy streak increments daily (if both hit goal)
- [ ] Buddy streak resets on miss
- [ ] Send emoji reaction
- [ ] Send text message
- [ ] Send nudge notification
- [ ] View buddy's real-time progress
- [ ] Unbuddy relationship

### Challenges
- [ ] View active challenge
- [ ] View upcoming challenges
- [ ] Join challenge
- [ ] Challenge leaderboard updates in real-time
- [ ] Your logs count toward challenge
- [ ] Leave challenge
- [ ] Challenge completes (timer reaches 0)
- [ ] Rewards distributed (cosmetics, XP)
- [ ] Challenge appears in "Completed" tab

### Leaderboards
- [ ] Global leaderboard loads
- [ ] Friends leaderboard shows only buddies
- [ ] XP leaderboard sorts by XP
- [ ] Your rank highlights
- [ ] Pull to refresh updates
- [ ] Infinite scroll loads more users
- [ ] User profile modal on tap
- [ ] Add user as buddy from leaderboard

### Gamification
- [ ] Level up animation/notification
- [ ] Achievement unlock notification
- [ ] Achievement appears in profile
- [ ] XP bar updates on log
- [ ] Cosmetic equipped changes UI
- [ ] Cosmetic shop loads
- [ ] Purchase cosmetic (if Phase 2)

### Notifications
- [ ] Hydration reminder arrives on time
- [ ] Buddy log notification
- [ ] Buddy streak notification
- [ ] Challenge rank notification
- [ ] Achievement unlock notification
- [ ] Tap notification opens relevant screen
- [ ] Disable notifications in settings works
- [ ] Mute buddy notifications silences that buddy only

### Dark Mode
- [ ] Light mode loads correctly
- [ ] Dark mode loads correctly
- [ ] Toggle dark mode switches instantly
- [ ] All screens readable in both modes
- [ ] Notch/safe areas respected

### Performance
- [ ] Home screen loads <1 second
- [ ] Leaderboard loads <2 seconds
- [ ] No janky animations (60 fps)
- [ ] App doesn't crash on rapid scrolling
- [ ] Memory doesn't leak (run for 10 mins)
- [ ] Battery usage reasonable (compare baseline)

### Error Handling
- [ ] Network error on home → show retry
- [ ] Server error on log → retry logic
- [ ] Invalid token → force logout
- [ ] Rate limiting → back off gracefully
- [ ] Duplicate buddy request → show error
- [ ] Missing required fields → validation error

### Edge Cases
- [ ] Log water at 11:59 PM
- [ ] Switch dates (midnight rolls over) → streak check
- [ ] Buddy pair in different timezones
- [ ] Log while offline → queue and sync
- [ ] Delete app and reinstall → data persists (cloud)
- [ ] Have 100+ buddies → list scrolls smoothly
- [ ] Very long username → truncate properly
- [ ] Empty bio (skip field)

### App Store Compliance
- [ ] Privacy Policy accessible
- [ ] Terms of Service accessible
- [ ] No ads (free tier)
- [ ] IAP for premium displays correctly
- [ ] IDFA handling (iOS)
- [ ] Permissions justified (Camera for QR, Notifications, etc.)
- [ ] Screenshots accurate
- [ ] App metadata complete
- [ ] Contacts not accessed (unless requested)
- [ ] No hardcoded API keys/secrets
- [ ] Analytics opt-out available

---

# PART 9: PERFORMANCE & OPTIMIZATION

## 9.1 Performance Targets

```
Metric                    Target          Threshold
─────────────────────────────────────────────────
Time to Interactive      < 2 seconds      OK if < 3s
Home Screen Load         < 1 second       OK if < 1.5s
Leaderboard Load         < 2 seconds      OK if < 2.5s
FPS (animations)         60 FPS           OK if > 50 FPS
Memory (at home)         < 100 MB         FAIL if > 150 MB
Battery (per hour)       < 5% battery     FAIL if > 10%
```

## 9.2 Optimization Strategies

### Code Optimization
```
1. Use const widgets where possible
2. Implement repaint boundaries for heavy widgets
3. Lazy load images with precaching
4. Minimize setState calls (use Riverpod providers)
5. Use ListView.builder for long lists
6. Implement efficient list diffing
7. Profile using DevTools (Dart VM profiling)
8. Enable code shrinking & minification on release builds
```

### Network Optimization
```
1. Compress images: Use WebP format, max 200KB per image
2. Pagination: Load 20 items per page, not all at once
3. Caching: Use GetStorage for local user data, logs
4. API request batching: Combine multiple requests (if applicable)
5. Connection pooling: Reuse TCP connections
6. Offline-first: Queue logs offline, sync on reconnect
```

### Database Optimization
```
1. Composite indexes for common queries:
   - users (createdAt, level) for leaderboard sorting
   - logs (userId, timestamp) for date range queries
   - dailyGoals (userId, date) for streak calculations
2. Limit Firestore reads:
   - Query only 20 docs per call, paginate
   - Use `limit()` to cap results
3. Batch reads/writes: Use batch() for multi-doc updates
4. Archive old logs (>6 months) to subcollection
```

### UI Optimization
```
1. Skeleton loading: Show placeholder while data loads
2. Progressive loading: Show partial data, load rest
3. Debounce search: Wait 300ms before querying
4. Throttle scroll: Limit event fire rate
5. Image lazy loading: Load images as user scrolls
6. Disable animations on low-end devices (if needed)
```

---

# PART 10: APP STORE REQUIREMENTS & SUBMISSION

## 10.1 iOS App Store Requirements

**Minimum iOS Version:** 13.0

**Required Screenshots (5 per language):**
1. Home screen (progress ring, stats)
2. Buddy streaks
3. Leaderboards
4. Challenges
5. Profile / Level

**Metadata:**
```
App Name: WaterBros
Subtitle: Stay Hydrated, Win Together
Keywords: water, hydration, fitness, social, challenges, leaderboard, buddy, habit
Description:

"Stay hydrated while competing with friends. WaterBros makes drinking water fun with buddy streaks, real-time leaderboards, and weekly challenges.

Track your water intake effortlessly with smart reminders. Build streaks with friends and climb the global leaderboard. Join rotating challenges and unlock cosmetics as you level up.

Features:
• Log water instantly with quick buttons or custom amounts
• Pair with friends to build persistent streaks
• Compete in weekly challenges (Volume, Consistency, Speed, and more)
• Climb 4 unique leaderboards (Global, Friends, City, XP)
• Unlock achievements and cosmetics as you progress
• Customize your profile with themes and avatar borders
• Get smart reminders based on your activity and climate

Available on iPhone and iPad."

Category: Health & Fitness
Rating: 4+
Privacy Policy: https://waterbros.app/privacy
Support URL: https://waterbros.app/support
```

**Privacy Declaration (IDFA):**
- [ ] Yes, we use IDFA for analytics (if yes, declare in App Store Connect)
- [ ] Implement SKAdNetwork compliance
- [ ] Request App Tracking Transparency (ATT) permission

**App Review Checklist:**
- [ ] No hardcoded server URLs (use config file)
- [ ] No executable code in assets
- [ ] No private APIs
- [ ] Proper error handling (no crash dialogs)
- [ ] Demo account not required (auth works without account)
- [ ] All features functional (no placeholder screens)
- [ ] No external payment links (all via in-app purchase)
- [ ] Comply with App Store payment policies
- [ ] WCAG 2.1 Level A accessibility
- [ ] Respect Do Not Track setting

**Test Account Credentials:**
- Provide test Apple ID for review team
- Account must have valid payment method
- Account should have data pre-populated (logs, buddies)

## 10.2 Google Play Store Requirements

**Minimum Android Version:** 8.0 (API 26)

**Target API Level:** 34+ (as of 2026)

**Required Assets:**
- App Icon: 512x512 PNG
- Feature Graphic: 1024x500 PNG
- Screenshots: 5-8 per language (1080x1920px)
- Video Promo (optional): MP4, max 30 seconds

**Metadata:**
```
(Same as iOS, adjusted for Android audience)
```

**Privacy Policy:**
- [ ] Linked in Play Store
- [ ] Privacy policy accessible in-app
- [ ] Declare data collection: emails, water logs, location (optional)
- [ ] Allow data deletion/export

**App Permissions Justification:**
```
android.permission.INTERNET
  → Required for Firebase backend

android.permission.POST_NOTIFICATIONS (API 33+)
  → Required for hydration reminders and buddy notifications

android.permission.CAMERA (optional)
  → Required for QR code scanning (buddy pairing)

android.permission.ACCESS_FINE_LOCATION (optional)
  → Required for city-based leaderboards (user must enable)

com.google.android.gms.permission.ACTIVITY_RECOGNITION
  → Required for activity detection (if Phase 2 includes)
```

**In-App Purchases:**
- Product ID: `waterbros_premium_monthly` ($2.99/mo)
- Product ID: `waterbros_premium_yearly` ($24.99/yr)
- Test SKUs for testing provided by Google

**Consent Declarations:**
- [ ] Declare all permissions truthfully
- [ ] No misleading icon/description
- [ ] Comply with Google Play policies on gambling/ads

## 10.3 Pre-Launch Checklist

**One Month Before Launch:**
- [ ] Finalize all copy/translations
- [ ] Create all store assets (screenshots, videos)
- [ ] Prepare privacy policy
- [ ] Set up Firebase project
- [ ] Create Apple App ID & Android app signing key
- [ ] Set up TestFlight for iOS beta
- [ ] Set up Google Play Internal Testing
- [ ] Recruit beta testers (50-100)
- [ ] Create press kit (logo, screenshots, description)

**Two Weeks Before:**
- [ ] Complete beta testing (all QA checklist items)
- [ ] Fix critical bugs from beta feedback
- [ ] Final version number: 1.0.0
- [ ] Final build for submission
- [ ] Prepare release notes (App Store/Play Store)
- [ ] Set up marketing calendar

**Launch Day:**
- [ ] Submit iOS to App Review (approval takes 24-48 hours)
- [ ] Submit Android to Play Store (approval takes 2-4 hours)
- [ ] Announce on Product Hunt, Reddit, Twitter
- [ ] Email beta testers: "App is live, please review"
- [ ] Monitor crash reports and ratings
- [ ] Be ready to hotfix critical bugs

---

# PART 11: DEPLOYMENT & RELEASE STRATEGY

## 11.1 Build Process

### iOS Build
```bash
cd ios
pod install
cd ..

flutter clean
flutter pub get

# Build for release
flutter build ios --release --verbose

# Creates: ios/Runner.xcarchive
# Open in Xcode → Archive → Upload to App Store Connect
```

### Android Build
```bash
flutter clean
flutter pub get

# Build for release
flutter build appbundle --release --verbose

# Creates: build/app/outputs/bundle/release/app-release.aab
# Upload to Google Play Console
```

### Web Build (Future)
```bash
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting
```

## 11.2 Release Phases

### Phase 1: Soft Launch (Week 1-2)
- Release to US & UK only
- Gather initial feedback
- Monitor crash rates
- Target metrics:
  - Crash-free sessions: 99%+
  - Avg session length: 3+ minutes
  - Sign-up conversion: 60%+

### Phase 2: Regional Expansion (Week 3-4)
- Expand to Canada, Australia, other English-speaking countries
- Monitor performance
- Implement fixes based on feedback

### Phase 3: Global Launch (Week 5+)
- Roll out to all countries
- Marketing push: influencers, ProductHunt, social media
- Target 50k+ downloads in first month

## 11.3 Versioning Scheme

**Format:** MAJOR.MINOR.PATCH

```
1.0.0 - Initial release
1.0.1 - Bug fix (critical)
1.1.0 - New feature (buddy squad mode)
2.0.0 - Major redesign or wearable support
```

**Release Notes Template:**
```
WaterBros 1.0.0 - Welcome to the Arena!

What's New:
✨ Log water, compete with friends, build streaks
✨ Real-time leaderboards (Global, Friends, City, XP)
✨ Weekly rotating challenges with rewards
✨ Unlock cosmetics and achievements as you level up
✨ Smart reminders based on your activity
✨ Dark mode support

Improvements:
🛠️ Optimized performance for faster loading
🛠️ Improved battery efficiency
🛠️ Better offline support

Bug Fixes:
🐛 Fixed crash on rapid log deletion
🐛 Fixed notification permissions on Android 13+
🐛 Fixed leaderboard sorting edge cases
```

---

# PART 12: EDGE CASES & ERROR HANDLING

## 12.1 Network Errors

| Scenario | Handling |
|----------|----------|
| No internet on app launch | Show "No connection" banner, allow cached view |
| Network timeout on log | Show retry button, queue log offline |
| Upload queue full (offline) | Show warning "Offline queue is full, connect to internet" |
| Partial sync failure | Retry with exponential backoff (1s, 2s, 4s, 8s) |
| API down | Show maintenance banner, graceful degradation |

## 12.2 Data Conflicts

| Scenario | Handling |
|----------|----------|
| Duplicate log submitted | Server deduplicates by deviceId + timestamp |
| Buddy request while already buddied | Show "Already buddies" error, don't duplicate |
| Simultaneous goal completion | Both updates queued, XP calculated correctly |
| Timezone changes (midnight) | Streak check happens in user's timezone (from settings) |
| Deleted buddy attempts message | Show "Buddy no longer in contacts" |

## 12.3 Input Validation

```
Username:
- Length: 3-30 characters
- Allowed: alphanumeric + underscore
- Check availability in real-time

Email:
- RFC 5322 validation
- Check if registered (signup)
- Max length: 254 chars

Password:
- Min 8 characters
- 1 uppercase letter
- 1 number
- 1 special character (!@#$%^&*)
- Max 128 characters

Water Amount:
- Positive integer only
- Max 5000ml (reasonable limit)
- Min 1ml

Bio:
- Max 150 characters
- Allow emoji
- No URLs (prevent spam)

Challenge Title:
- Max 50 characters
- Alphanumeric + spaces
```

## 12.4 State Machine for User Onboarding

```
[Unauthenticated]
    ↓ (sign_up)
[Profile Setup]
    ↓ (complete_profile)
[Permissions Request] (skippable)
    ↓ (allow/deny)
[Home] (first time)
    ├─ (add_buddy) → Buddy suggestions
    └─ (skip) → Dashboard

[Authenticated + Incomplete Profile] → Redirect to profile setup
[Authenticated + Complete Profile] → Home
```

## 12.5 Retry Logic

```
Strategy: Exponential backoff with jitter

function attemptRequest(request, maxRetries = 3) {
  let delay = 1000; // 1 second
  
  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await request();
    } catch (error) {
      if (error.statusCode in [4xx, 401, 403]) {
        throw error; // Don't retry client errors
      }
      
      if (attempt < maxRetries - 1) {
        const jitter = Math.random() * 0.1 * delay;
        await sleep(delay + jitter);
        delay *= 2; // Exponential backoff
      }
    }
  }
}
```

---

# PART 13: MONITORING & ANALYTICS DASHBOARD

## 13.1 Key Metrics to Monitor

```
Real-Time Dashboard:
- Active users (right now)
- Current app version
- Top 5 countries
- Top 5 crash signatures

Daily Dashboard:
- DAU (Daily Active Users)
- New sign-ups
- Session length (avg)
- Crash-free sessions %
- Top feature by usage

Weekly Dashboard:
- Retention curves (D1, D7, D30)
- Churn rate
- Challenge participation rate
- Buddy pairing rate
- Feature adoption %
- Top issues reported

Monthly Dashboard:
- MAU (Monthly Active Users)
- Installation sources (organic, paid, referral)
- Cohort analysis (sign-up cohorts by retention)
- Revenue (if monetized)
- AppStore/PlayStore rating
```

## 13.2 Critical Alerts

```
IF crash_free_sessions < 98%
  → Page on-call engineer

IF > 100 crashes in 1 hour
  → Rollback previous version

IF sign_up_conversion < 50%
  → Investigate auth issues

IF avg_session_length < 2 minutes
  → Check for UI/UX issues or bugs

IF > 500 "network timeout" errors
  → Investigate server/API issues
```

---

# APPENDIX A: DESIGN TOKENS (Figma Style Guide)

**Color Variables:**
```
colors/primary: #2563EB
colors/secondary: #06B6D4
colors/success: #10B981
colors/error: #EF4444
colors/neutral/900: #0F172A
colors/neutral/50: #F8FAFC
```

**Typography Variables:**
```
display/large: 32px, weight 700
heading/large: 24px, weight 600
body/large: 16px, weight 400
```

**Spacing Variables:**
```
spacing/xs: 4px
spacing/sm: 8px
spacing/md: 16px
spacing/lg: 24px
spacing/xl: 32px
```

---

# APPENDIX B: API Rate Limiting

```
Default: 100 requests per minute per user

Endpoints with stricter limits:
POST /auth/login: 5 attempts per 15 minutes
POST /buddies/request: 10 per hour
POST /challenges/join: No limit (but prevents spam via FK constraints)

On rate limit exceeded:
Status: 429 Too Many Requests
Response: { "retryAfter": 60 }
Client: Implement exponential backoff
```

---

# APPENDIX C: Localization Roadmap

**Launch Languages:**
- English (US, UK)

**Phase 2 (Month 3):**
- Spanish (ES, MX)
- French (FR)
- German (DE)

**Phase 3 (Month 6):**
- Japanese (JA)
- Mandarin (ZH)
- Hindi (HI)
- Portuguese (PT-BR)

**RTL Languages (Future):**
- Arabic (AR)
- Hebrew (HE)

---

# APPENDIX D: 8-Week Development Timeline

```
Week 1-2: Core infrastructure
  - Firebase setup
  - Auth (email, Google, Apple)
  - User profile setup
  - Basic UI foundation

Week 3: Water logging & home screen
  - Water log creation/editing
  - Progress ring
  - Daily goal tracking
  - XP calculation

Week 4: Buddy system
  - Add buddy (search, QR, link)
  - Buddy detail screen
  - Real-time updates
  - Buddy streaks

Week 5: Challenges
  - Challenge display
  - Join/leave logic
  - Leaderboards
  - Real-time updates

Week 6: Gamification
  - Achievements system
  - Cosmetic system
  - Level progression
  - Notifications

Week 7: Polish & optimization
  - Performance optimization
  - Accessibility fixes
  - Dark mode refinement
  - Bug fixes

Week 8: Testing & submission
  - Beta testing
  - App Store submission
  - Marketing materials
  - Launch day prep
```

---

**END OF PRD**

**Document Prepared For:** AntiGravity Development Team  
**Status:** READY FOR DEVELOPMENT  
**Approval:** Product Manager (Archi)  
**Version:** 2.0 Production  
**Date:** June 2026  

**Questions?** Refer to Section numbers in TOC. All screen flows, technical specs, and requirements are self-contained in this document.