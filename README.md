# 🦶👣 GentleStep

<p align="center">
  <img src="https://img.shields.io/badge/Apple-Swift%20Student%20Challenge-black?logo=apple&logoColor=white" />
  <img src="https://img.shields.io/badge/Swift-SwiftUI-orange?logo=swift&logoColor=white" />
</p>

A fully offline ankle mobility companion built with SwiftUI for the **Apple Swift Student Challenge**.

---

## 📖 Overview

GentleStep is a calm, focused rehabilitation companion designed to guide seniors recovering from mild ankle discomfort through simple, safe daily mobility exercises.

The app is intentionally designed to be experienced within three minutes, aligning with the Swift Student Challenge guidelines.

---

## 🎯 Problem

Many seniors recovering from mild ankle injuries lack clear, simple guidance for performing mobility exercises independently at home. Existing resources are often overly complex or difficult to follow.

GentleStep provides:

* Three gentle guided exercises
* Animated ankle movement demonstrations
* Timed sessions with subtle haptic feedback
* Simple streak tracking for consistency
* A calm, distraction-free interface

The app supports daily mobility confidence while maintaining clarity and restraint.

---

## ✨ Features

* ✅ Fully offline (no networking or third-party dependencies)
* ✅ Built entirely with SwiftUI
* ✅ Custom oscillating ankle animation (15° easeInOut motion system)
* ✅ Reusable circular progress ring component
* ✅ 30-second guided sessions
* ✅ Subtle haptic feedback every 10 seconds
* ✅ Accessibility-first design
* ✅ Streak tracking using UserDefaults
* ✅ Motion aligned with Apple Human Interface Guidelines

---

### Core Components

* **Exercise Model** – Defines exercise metadata
* **ExerciseTimerViewModel** – Manages timer logic and progress updates
* **ProgressRing** – Custom Shape-based animated progress indicator
* **AnkleAnimationView** – Oscillating ankle animation using rotationEffect
* **StreakManager** – Lightweight local persistence using UserDefaults

No external frameworks or networking layers were used to maintain reliability and simplicity.

---

## ♿ Accessibility

Accessibility was a foundational design principle:

* Large system typography (SF Pro)
* High-contrast pastel color system
* Minimum 44pt interactive elements
* VoiceOver support with descriptive labels
* Reduce Motion compatibility
* Calm, physiotherapy-appropriate animation timing

---

## 🎨 Design Philosophy

The visual system emphasizes restraint:

* Soft beige background
* Mint accent
* Peach highlight
* Generous whitespace
* No spring or flashy transitions
* Subtle motion curves (easeInOut, 2.2s duration)
* My Preview 👇

![WhatsApp Image 2026-02-20 at 11 44 26 PM (2)](https://github.com/user-attachments/assets/20d4109a-5bcb-4727-8ac7-43a2ad679712)
![WhatsApp Image 2026-02-20 at 11 44 26 PM (1)](https://github.com/user-attachments/assets/01b926e5-7750-422a-831f-fc21eff6cb92)
![WhatsApp Image 2026-02-20 at 11 44 26 PM](https://github.com/user-attachments/assets/839d8e11-dc3a-48c3-8aa9-fc7d920c2a3c)
![WhatsApp Image 2026-02-20 at 11 44 25 PM](https://github.com/user-attachments/assets/bf44c477-3785-43f1-87ab-fd4f9edeedca)

The goal was clarity, not complexity.

---

## 🛠 Technologies

* Swift
* SwiftUI
* Foundation
* UserDefaults
* Core Haptics

Built for Swift Playgrounds.

---



## 🏆 Swift Student Challenge

This project was created as a submission for the **Apple Swift Student Challenge**.
---
       
