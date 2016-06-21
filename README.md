# OpenSSL-WinRT-build

Contains script to produce OpenSSL static libraries for Windows8.1/Store and Windows10/UWP. Custom [Micrsoft fork](https://github.com/Microsoft/openssl/tree/OpenSSL_1_0_2_WinRT-stable) is currently used so that generated libs could pass Windows Submission.

## Installation Instructions

### Requirements

* OS Windows10 x64
* [Perl](http://www.activestate.com/activeperl) (perl location must be in your *PATH* environmental variable).
* [Visual Studio 2015](https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx). Ensure *Windows Developer tools* are installed as part of *Visuals Studio* or install them separately:
   - Tools for Windows 10 [https://developer.microsoft.com/en-us/windows/downloads]
   - Tools for Windows 8.1 [https://developer.microsoft.com/en-us/windows/downloads/windows-8-1-sdk]

### To clone the repo

```
  git clone --recursive https://github.com/sgrebnov/OpenSSL-WinRT-build
```
or
```
git clone https://github.com/sgrebnov/OpenSSL-WinRT-build
cd OpenSSL-WinRT-build
git submodule update --init --recursive
```

## Build

Run `build.cmd` from repo root folder. Upon successful build you should see the following message
```
"Build completed; results could be found in './build' folder"
```
The build script will create `build` folder with the following build artefacts:

* `build/include` - contains header files (includes)
* `build/libs/win81/(win32|x64|arm)/libeay32.lib` - generated openssl static libraries for Windows8.1 (both desktop/tablet and phone)
* `build/libs/uwp/(win32|x64|arm)/libeay32.lib` - generated openssl static libraries for Windows10 (Universal Windows Platform)

_Note_: build takes a long time, 10-20mins.

## Copyrights ##
LICENSE: MIT or Apache 2.0 (TBD subject to change)
