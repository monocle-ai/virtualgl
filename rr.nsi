Name ${APPNAME}
OutFile ${BLDDIR}\${APPNAME}.exe
InstallDir $PROGRAMFILES\${APPNAME}-${VERSION}-${BUILD}

SetCompressor bzip2

Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

Section "${APPNAME}-${VERSION}-${BUILD} (required)"
	SectionIn RO
	SetOutPath $INSTDIR
	File "${BLDDIR}\bin\vglclient.exe"
	File "${BLDDIR}\bin\hpjpeg.dll"
	File "${BLDDIR}\bin\tcbench.exe"
	File "${BLDDIR}\bin\nettest.exe"
	File "${BLDDIR}\bin\hclshm.dll"
	File "${BLDDIR}\bin\xlib.dll"
	File "$%systemroot%\system32\libeay32.dll"
	File "$%systemroot%\system32\ssleay32.dll"
	File "doc\winug.html"
	File /r /x CVS "doc\winug"
	File "doc\config.html"
	File /r /x CVS "doc\config"
	File "LGPL.txt"
	File "LICENSE.txt"
	File "LICENSE-OpenSSL.txt"

	WriteRegStr HKLM "SOFTWARE\${APPNAME}-${VERSION}-${BUILD}" "Install_Dir" "$INSTDIR"

	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}-${VERSION}-${BUILD}" "DisplayName" "${APPNAME} Client v${VERSION} (${BUILD})"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}-${VERSION}-${BUILD}" "UninstallString" '"$INSTDIR\uninstall.exe"'
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}-${VERSION}-${BUILD}" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}-${VERSION}-${BUILD}" "NoRepair" 1
	WriteUninstaller "uninstall.exe"
SectionEnd

Section "Start Menu Shortcuts (required)"

	SetShellVarContext all
	CreateDirectory "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})"
	CreateShortCut "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\Uninstall ${APPNAME} Client.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
	CreateShortCut "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\Install ${APPNAME} Client as a Service.lnk" "$INSTDIR\vglclient.exe" "-install"
	CreateShortCut "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\Remove ${APPNAME} Client Service.lnk" "$INSTDIR\vglclient.exe" "-remove"
	CreateShortCut "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\Install ${APPNAME} Secure Client as a Service.lnk" "$INSTDIR\vglclient.exe" "-s -install"
	CreateShortCut "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\Remove ${APPNAME} Secure Client Service.lnk" "$INSTDIR\vglclient.exe" "-s -remove"
	CreateShortCut "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\Start ${APPNAME} Client.lnk" "$INSTDIR\vglclient.exe"
	CreateShortCut "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\Start ${APPNAME} Secure Client.lnk" "$INSTDIR\vglclient.exe" "-s"
	CreateShortCut "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\${APPNAME} User's Guide.lnk" "$INSTDIR\winug.html"
	CreateShortCut "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\${APPNAME} Configuration Guide.lnk" "$INSTDIR\config.html"

SectionEnd

Section "Uninstall"

	SetShellVarContext all
	ExecWait "$INSTDIR\vglclient.exe -q -remove"
	ExecWait "$INSTDIR\vglclient.exe -q -s -remove"

	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}-${VERSION}-${BUILD}"
	DeleteRegKey HKLM "SOFTWARE\${APPNAME}-${VERSION}-${BUILD}"

	Delete $INSTDIR\vglclient.exe
	Delete $INSTDIR\hpjpeg.dll
	Delete $INSTDIR\uninstall.exe
	Delete $INSTDIR\stunnel.rnd
	Delete $INSTDIR\tcbench.exe
	Delete $INSTDIR\nettest.exe
	Delete $INSTDIR\hclshm.dll
	Delete $INSTDIR\xlib.dll
	Delete $INSTDIR\libeay32.dll
	Delete $INSTDIR\ssleay32.dll
	Delete $INSTDIR\winug.html
	Delete $INSTDIR\winug\*.*
	RMDir $INSTDIR\winug
	Delete $INSTDIR\config.html
	Delete $INSTDIR\config\*.*
	RMDir $INSTDIR\config
	Delete $INSTDIR\LGPL.txt
	Delete $INSTDIR\LICENSE.txt
	Delete $INSTDIR\LICENSE-OpenSSL.txt

	Delete "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})\*.*"
	RMDir "$SMPROGRAMS\${APPNAME} Client v${VERSION} (${BUILD})"
	RMDir "$INSTDIR"

SectionEnd
