; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "DavMail"
!define PRODUCT_VERSION "${VERSION}"
!define PRODUCT_PUBLISHER "Micka�l Guessant"
!define PRODUCT_WEB_SITE "http://sourceforge.net/projects/davmail"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\davmail.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI2.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "src\license.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\davmail.exe"
!define MUI_FINISHPAGE_SHOWREADME "" #Used as auto start option
  !define MUI_FINISHPAGE_SHOWREADME_TEXT "Always launch DavMail at log on"
  !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
  !define MUI_FINISHPAGE_SHOWREADME_FUNCTION AddRunKey
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "French"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "dist\davmail-${PRODUCT_VERSION}-setup.exe"
InstallDir "$PROGRAMFILES\DavMail"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

LangString PAGE_TITLE ${LANG_ENGLISH} "Title"
LangString PAGE_SUBTITLE ${LANG_ENGLISH} "Subtitle"

Function AddRunKey
  WriteRegStr HKEY_CURRENT_USER "Software\Microsoft\Windows\CurrentVersion\Run" "DavMail" "$INSTDIR\davmail.exe"
FunctionEnd

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd


Section
Push $5
loop:
  push "davmail.exe"
  processwork::existsprocess
  pop $5
  IntCmp $5 0 no_quest
  MessageBox MB_RETRYCANCEL|MB_ICONSTOP 'DavMail must be closed during this installation.$\r$\n Close DavMail now, or press "Retry" to automatically close DavMail and continue or press "Cancel" to cancel the installation entirely.'  IDCANCEL BailOut
  push "davmail.exe"
  processwork::KillProcess
  Sleep 2000
Goto loop

BailOut:
  Abort

no_quest:
SectionEnd

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite try
  File "dist\davmail.exe"
  CreateDirectory "$SMPROGRAMS\DavMail"
  CreateShortCut "$SMPROGRAMS\DavMail\DavMail.lnk" "$INSTDIR\davmail.exe"
  CreateShortCut "$SMPROGRAMS\DavMail\DavMail Console.lnk" "$INSTDIR\davmailconsole.exe"
  CreateShortCut "$DESKTOP\DavMail.lnk" "$INSTDIR\davmail.exe"
  File "dist\davmail.jar"
  File "dist\davmailconsole.exe"
  File "dist\davmailservice.exe"
  File "dist\davmail64.exe"
  File "dist\davmailservice64.exe"
  SetOutPath "$INSTDIR\lib"
  File "dist\lib\activation-1.1.1.jar"
  File "dist\lib\commons-codec-1.15.jar"
  File "dist\lib\commons-collections-3.1.jar"
  File "dist\lib\httpcore-4.4.16.jar"
  File "dist\lib\httpclient-4.5.14.jar"
  File "dist\lib\commons-logging-1.0.4.jar"
  File "dist\lib\htmlcleaner-2.29.jar"
  File "dist\lib\jackrabbit-webdav-2.20.15.jar"
  File "dist\lib\jcharset-2.0.jar"
  File "dist\lib\jcifs-1.3.19.jar"
  File "dist\lib\jdom-1.0.jar"
  File "dist\lib\jettison-1.5.4.jar"
  File "dist\lib\log4j-1.2.17.jar"
  File "dist\lib\javax.mail-1.6.2.jar"
  File "dist\lib\slf4j-api-1.7.25.jar"
  File "dist\lib\slf4j-log4j12-1.7.25.jar"
  File "dist\lib\stax-api-1.0.1.jar"
  File "dist\lib\stax2-api-3.1.1.jar"
  File "dist\lib\winrun4j-0.4.5.jar"
  File "dist\lib\woodstox-core-6.4.0.jar"
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\DavMail\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\DavMail\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\davmail.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\davmail.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) has been removed from your system."
FunctionEnd

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
Push $5
loop:
  push "davmail.exe"
  processwork::existsprocess
  pop $5
  IntCmp $5 0 no_quest
  MessageBox MB_RETRYCANCEL|MB_ICONSTOP 'DavMail must be closed during this installation.$\r$\n Close DavMail now, or press "Retry" to automatically close DavMail and continue or press "Cancel" to cancel the installation entirely.'  IDCANCEL BailOut
  push "davmail.exe"
  processwork::KillProcess
  Sleep 2000
Goto loop

BailOut:
  Abort

no_quest:
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  
  Delete "$INSTDIR\lib\activation-1.1.1.jar"
  Delete "$INSTDIR\lib\commons-codec-1.15.jar"
  Delete "$INSTDIR\lib\commons-collections-3.1.jar"
  Delete "$INSTDIR\lib\httpcore-4.4.16.jar"
  Delete "$INSTDIR\lib\httpclient-4.5.14.jar"
  Delete "$INSTDIR\lib\commons-logging-1.0.4.jar"
  Delete "$INSTDIR\lib\htmlcleaner-2.29.jar"
  Delete "$INSTDIR\lib\jackrabbit-webdav-2.20.15.jar"
  Delete "$INSTDIR\lib\jcharset-2.0.jar"
  Delete "$INSTDIR\lib\jcifs-1.3.19.jar"
  Delete "$INSTDIR\lib\jdom-1.0.jar"
  Delete "$INSTDIR\lib\jettison-1.5.4.jar"
  Delete "$INSTDIR\lib\log4j-1.2.17.jar"
  Delete "$INSTDIR\lib\javax.mail-1.6.2.jar"
  Delete "$INSTDIR\lib\slf4j-api-1.7.25.jar"
  Delete "$INSTDIR\lib\slf4j-log4j12-1.7.25.jar"
  Delete "$INSTDIR\lib\stax-api-1.0.1.jar"
  Delete "$INSTDIR\lib\stax2-api-3.1.1.jar"
  Delete "$INSTDIR\lib\winrun4j-0.4.5.jar"
  Delete "$INSTDIR\lib\woodstox-core-6.4.0.jar"

  Delete "$INSTDIR\davmailservice64.exe"
  Delete "$INSTDIR\davmail64.exe"
  Delete "$INSTDIR\davmailservice.exe"
  Delete "$INSTDIR\davmailconsole.exe"
  Delete "$INSTDIR\davmail.log"
  Delete "$INSTDIR\davmail.jar"
  Delete "$INSTDIR\davmail.exe"

  Delete "$SMPROGRAMS\DavMail\Uninstall.lnk"
  Delete "$SMPROGRAMS\DavMail\Website.lnk"
  Delete "$DESKTOP\DavMail.lnk"
  Delete "$SMPROGRAMS\DavMail\DavMail.lnk"
  Delete "$SMPROGRAMS\DavMail\DavMail Console.lnk"

  RMDir "$SMPROGRAMS\DavMail"
  RMDir "$INSTDIR\lib"
  RMDir "$INSTDIR"

  DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "DavMail"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd