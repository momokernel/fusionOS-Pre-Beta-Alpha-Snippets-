fusionOS — Pre-Alpha / Beta Snippets
Overview

This repository captures the earliest functional stages of fusionOS. It shows the transition from a simple bootloader concept to the first version that actually behaves like a system.

This is not a stable release. It is a raw snapshot taken during a phase where ideas are still being tested directly in code.

Right now, the repository includes both the original bootloader foundation and an early, modified version of fusionOS 0.2. That version is not clean or consistent, but it runs, and that matters more at this stage than perfection.

fusionOS 0.2 itself is an archived build from November 14, 2024. It is preserved here intentionally, as this repository exists to document early development states. Since then, the project has moved significantly beyond what 0.2 represents.

fusionOS 0.2

With version 0.2, fusionOS crosses an important line. It is no longer just about booting, it starts to show interaction.

The most notable addition is the experimental exp function. It launches a very minimal desktop-like environment with a visible cursor. This is not meant to be complete or polished. It exists to prove that a graphical interaction layer can work and to make the underlying logic easier to understand.

Before committing, parts of this version were intentionally simplified. Some internal logic was adjusted so that core concepts are easier to follow, even if that means the implementation is not ideal.

Another major change is the switch to GRUB for booting this version. This allows direct kernel testing without being fully tied to the custom bootloader, which makes iteration faster and more flexible.

fusionOS 0.2 can also be booted directly in VirtualBox, which removes a lot of friction when testing.

Repository Contents

The repository still includes the original low-level components. These represent the starting point of the project and are kept for transparency.

bootloader.asm contains the first stage bootloader written for the MBR.
stage2.asm handles the second stage, including the menu and protected mode transition.
The Makefile is used to build the boot components.
The included boot image represents the early standalone bootloader setup.

The fusionOS 0.2 state exists alongside this as an experimental step forward.

Technical Scope

This project operates very close to the hardware. It exposes how a system actually starts and evolves from nothing.

It includes the transition from 16-bit real mode to 32-bit protected mode, basic disk access through BIOS interrupts, and the first attempts at building a graphical layer on top of that.

Nothing is abstracted away. What you see is exactly what the system does.

Limitations

This repository is not a finished product, and it should not be treated like one.

fusionOS 0.2 is unstable. Parts of the system behave inconsistently. The desktop experience is extremely minimal and not persistent. Core components like memory management, drivers, and filesystem support are either incomplete or missing.

Some parts of the code are intentionally simplified, which also means they are not optimized or production-ready.

Purpose

The goal of this repository is to make the early development of fusionOS visible and understandable.

It is meant for people who want to see how an operating system starts from scratch, and how individual pieces come together over time.

At the same time, it serves as a working base for further experimentation and iteration.

Usage

You can run fusionOS 0.2 directly in VirtualBox for a straightforward test.

If you want to work with the bootloader itself, QEMU is still the better option.

To build the project, install NASM and QEMU, then run make.
To start the test environment, run make test.

For GRUB-based setups, the kernel needs to be integrated manually into your configuration.

Current Development

fusionOS has already moved far beyond the state represented in this repository.

More recent progress, along with the current development direction, will be available starting end of April / early May on the upcoming momokernels website (version 1.2.1).

This repository remains focused on preserving the early stages that led to that point.
