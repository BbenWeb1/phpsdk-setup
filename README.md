# phpsdk-setup
 PHPSDK-SETUP to set up an environment for building and testing PHP extensions on Windows.
## NOTE 
**The Project Is A Rewrite Of The Oreginal Project** 
[Setup PHP-SDK](https://github.com/cmb69/setup-php-sdk)


 ## 1-Download and Setup
 - `git clone https://github.com/BbenWeb1/phpsdk-setup.git`
 - Open Folder phpsdk-setup With `PowerShell Windows`
 - Run File `.\setup-sdk` 

## Inputs
- `version`: the PHP version to build for
  (`7.0`, `7.1`, `7.2`, `7.3`, `7.4`, `8.0`,`8.1` or `8.2`)
- `arch`: the architecture to build for (`x64` or `x86`)
- `ts`: thread-safety (`nts` or `ts`)

## Example Install Extension OpenCV-PHP
### Tools
- Install Visual studio 19 In Windows 
- Download OpenCV C++ `https://github.com/spmallick/learnopencv/tree/master/Install-OpenCV-Windows-exe ` and Extract Content To `C:\OpenCV`
- Download And Setup `phpsdk-setup`
(Example `Version:8.0`,`arch:x64`,`ts:ts`)
- Download Git From `https://git-scm.com/downloads` and Install
### Setup
- Open Folder phpsdk
- invoke  `phpsdk-vc16-x64.bat`
- `run` 
- `git clone https://github.com/BbenWeb1/php-opencv.git`
- `cd php-opencv`
-  `..\..\..\..\..\..\..\php-dev\phpize.bat`
- `configure --help`
- `configure --with-opencv`
- `nmake`
- Wait For The Installation To Finish
- `cd x64\Release_TS` Find File `php_opencv.dll`

## Add File OpenCV-Php DLL To Xampp
- Copy File `php_opencv.dll` To `C:\xampp\php\ext`
- Copy Files DLL From `C:\OpenCV\x64\vc16\bin` To `C:\xampp\php`
- Open File php.ini `C:\xampp\php\php.ini`
- Add  `extension=php_opencv` and Save 
