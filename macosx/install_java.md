# *Java on Mac OS X*

## *Installing Java on Mac OS X*

You can manually download the latest Java JDK from this site:

* [Download Java Homepage](http://www.oracle.com/technetwork/java/javase/downloads/index.html) - Download desired ***JDK***.
   * [Java 7 JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)
   * [Java 8 JDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

### *Automating Installations (Command-Line with Curl)*

#### *Java JDK 7 - Mac OS X*

```bash
VERSION="7u79-b15"
SHORTVER="$(echo ${VERSION} | cut -d- -f1)"
PACKAGE="jdk-${SHORTVER}-macosx-x64.dmg"
DOWNLOAD="http://download.oracle.com/otn-pub/java/jdk/${VERSION}/${PACKAGE}"
HEADER='Cookie: oraclelicense=accept-securebackup-cookie'
# Download
curl -v -j -k -L -H "${HEADER}" ${DOWNLOAD} > ${HOME}/Downloads/${PACKAGE}
# Install
hdiutil attach ${HOME}/Downloads/${PACKAGE}
# Install Package
MAJORVER="$(echo $SHORTVER | grep -o '^\d')"
MINORVER="$(echo $SHORTVER | grep -o '\d\d$')"
sudo installer -pkg "/Volumes/JDK ${MAJORVER} Update ${MINORVER}/JDK ${MAJORVER} Update ${MINORVER}.pkg" -target /
```

#### *Java JDK 8 - Mac OS X*

```bash
VERSION="8u72-b15"
SHORTVER="$(echo ${VERSION} | cut -d- -f1)"
PACKAGE="jdk-${SHORTVER}-macosx-x64.dmg"
DOWNLOAD="http://download.oracle.com/otn-pub/java/jdk/${VERSION}/${PACKAGE}"
HEADER='Cookie: oraclelicense=accept-securebackup-cookie'
# Download
curl -v -j -k -L -H "${HEADER}" ${DOWNLOAD} > ${HOME}/Downloads/${PACKAGE}
# Mount Image
hdiutil attach ${HOME}/Downloads/${PACKAGE}
# Install Package
MAJORVER="$(echo $SHORTVER | grep -o '^\d')"
MINORVER="$(echo $SHORTVER | grep -o '\d\d$')"
sudo installer -pkg "/Volumes/JDK ${MAJORVER} Update ${MINORVER}/JDK ${MAJORVER} Update ${MINORVER}.pkg" -target /
```

## *Configuring Java on Mac OS X*

You can add this function to your `~/.bash_profile`:

```bash
function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
 }
 function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
 }

### SET JAVA VERSION
setjdk 1.8
```

After just use `setjdk 1.7` for Java 7 JDK or `setjdk 1.8` for Java 8 JDK.
