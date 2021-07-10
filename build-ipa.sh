flutter build ipa
CUR=$PWD
cd ./build/ios/archive/Runner.xcarchive/Products/Applications
mkdir Payload
cp -r Runner.app Payload/Runner.app
zip -r output.ipa Payload
rm -rf Payload
cd ../../../../
mkdir ./ipa
cd ./ipa
mv ../archive/Runner.xcarchive/Products/Applications/output.ipa ./
cd $CUR
