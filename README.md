# Carbon Footprint Calculator

**Developer:** Johan Nel  
**Grade:** 12-5  
**School:** Hoërskool Secunda  
**Year:** 2023  
**Project Type:** IT PAT (Practical Assessment Task)  
**Language:** Delphi 2010  
**Database:** Microsoft Access (`CarbonFootprintDB.mdb`)

---

## Overview

The **Carbon Footprint Calculator** is a desktop application developed for my Grade 12 IT PAT. It helps users calculate their personal carbon footprint based on electricity usage and fuel consumption. The program also educates users on climate change and provides tips to reduce their environmental impact.

---

## Purpose

This program is designed to:
- Show users how their lifestyle and electricity usage contributes to carbon emissions.
- Provide tips on how to reduce their carbon footprint.
- Allow administrators to maintain accurate emission data for better calculations.

---

## Users & Roles

### Normal User
- Register and log in
- Enter personal electricity and generator usage
- View and compare their carbon footprint
- Receive helpful tips to reduce carbon output

### Administrator
- Register and log in
- Update carbon emission data for different generators and electricity types
- Generate reports such as averages and extremes
- Maintain data consistency and accuracy

### Developer
- Maintain, debug, and enhance program features
- Update `.txt` files and database entries as needed

---

## Database Design

- **tblUsers**: Stores user information
- **tblEmission**: Stores emission values
- **tblGenerator**: Stores generator types and emissions
- **tblElectricity**: Records user electricity usage and calculated emissions

Relationships include:
- `Username` links `tblUsers` and `tblElectricity`
- `EmissionType` links `tblEmission`, `tblElectricity`, and `tblGenerator`

---

## Key Features

- User-friendly login and sign-up interface
- Random climate facts on UI for engagement
- Emission calculations based on:
  - Main grid electricity
  - Generator usage
- Custom encryption for password security
- Array usage for efficient data handling
- Helpful text files for countries, tips, and help messages
- GUI toggles for viewing graphs and tips

---

## File Structure

- `CarbonFootprintDB.mdb` – Database file
- `Countries.txt` – List of supported countries
- `Facts\[FactFile].txt` – Fun environmental facts
- `Help\[HelpFile].txt` – Help text for UI
- `Administrator.txt` – Recognized admin names
- `MainProgram\` – Contains compiled program and resources

---

## Validation & Error Handling

Extensive input validation is used during:
- Signup (username, password, date of birth, etc.)
- Login
- Admin updates to emissions

Error messages are clear and instructive for user correction.

---

## GUI Highlights

- `frmSignupLogin` – Registration & login with fact panel
- `frmNormalUser` – Dashboard for footprint tracking and tips
- `frmAdmin` – Admin dashboard for emission data management

---

## Resources & References

- [Delphi Basics](https://www.delphibasics.co.uk/)
- [Password Encryption technique](https://edn.embarcadero.com/article/28325)
- [Country list](https://gist.github.com/kalinchernev/486393efcca01623b18d)

---
