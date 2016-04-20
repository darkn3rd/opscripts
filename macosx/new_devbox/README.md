# **New DevBox System for OS X**

Here are some tools to get you started with creating a development system on Mac OS X.  Comment out stuff that you do not want.

## **Prerequisites**

Install XCode Command Line Tools.

If you downloaded XCode from https://developer.apple.com, run this before for launching XCode: `xattr -d com.apple.quarantine Xcode.app`

## **Usage**

### **Homebrew**

Run `./get_homebrew.sh` to install Homebrew and Brew Bundle.  

### **Tools**

Install common tools:

```bash
$ pushd tools
$ brew bundle
$ ./post-brew.sh
$ source environ.sh   # purdy colors - add to ~/.bash_profile
$ popd
```

### **Development Apps and Tools**

Install common tools:

```bash
$ pushd dev
$ brew bundle
$ ./post-brew.sh         # install more stuff
$ ./config.sh            # remove some Mac OS X annoyances
$ source ./functions.sh  # convenience functions - add to ~/.bash_profile
$ popd
```

### **Applications**

These are some applications I use that you might like:

```bash
$ pushd apps
$ brew bundle
$ popd
```
