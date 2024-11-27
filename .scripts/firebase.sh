#!/bin/bash -l

dev="Dev-"
beta="Beta-"
debug="-Debug"
path=""

if [[ "${CONFIGURATION}" == *"${dev}"* ]]; then
path="${PROJECT_DIR}/LearnConnect/SupportingFiles/Firebase/Configs/GoogleService-Info-Dev.plist"
elif [[ "${CONFIGURATION}" == *"${beta}"* ]]; then
path="${PROJECT_DIR}/LearnConnect/SupportingFiles/Firebase/Configs/GoogleService-Info-Beta.plist"
else
path="${PROJECT_DIR}/LearnConnect/SupportingFiles/Firebase/Configs/GoogleService-Info.plist"
fi

echo "Firebase Config file:"
cat $path

"${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"

chmod +x ${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols
${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols -gsp $path -p ios "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"

