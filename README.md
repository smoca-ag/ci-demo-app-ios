# Project Setup iOS

In order for this to work a fastlane match certificates repository needs to be set up. You also need to be logged in with a developer account inside of Xcode. This developer account must be part of a valid team. Lastly you will need a developer provisioning profile for the App ID "*".

1. Project configuration in Xcode

   1. Uncheck "Automatically manage signing" for all debug targets. Then choose a provisioning profile with the App ID "*".  You might need to download it first. Also select your team if necessary.
   2. Share the build scheme of the App.

2. Open a Terminal and navigate to the project and run:

   ```
   fastlane init
   ```

   Chose "Manual Setup" when asked.

3. Create a Matchfile and a Scanfile.

   ```
   cd fastlane/
   touch Matchfile
   touch Scanfile
   ```

4. Insert the following code into the Matchfile:

   ```
   git_url ENV['CI_REPOSITORY_URL'].sub(ENV['CI_PROJECT_PATH'], 'nameOfCertificatesRepo')

   type "development" # The default type, can be: appstore, adhoc, enterprise or development

   team_name "your team name"

   app_identifier ["*"]
   # username "user@fastlane.tools" # Your Apple Developer Portal username

   # For all available options run `fastlane match --help`
   # Remove the # in the beginning of the line to enable the other options
   ```

5. Insert the following code into the Scanfile:

   ```
   # For more information about this configuration visit
   # https://docs.fastlane.tools/actions/scan/#scanfile

   # In general, you can use the options available
   # fastlane scan --help

   # Remove the # in front of the line to enable the option

   derived_data_path "./derivedData"

   clean true

   scheme "Demo-iOS"
   ```

6. Open `fastlane/Fastfile` and replace the existing lane with the following:

   ```
   	desc "Runs tests on all devices"
   	lane :test do

   		match(readonly: true)

   		# Gets udids of connected iOS devices.
   		sh("system_profiler SPUSBDataType | sed -n -e '/iPad/,/Serial/p' -e '/iPhone/,/Serial/p' | grep \"Serial Number:\" | awk -F \": \" '{print $2}' > udids.temp")
   		udids = File.readlines('./udids.temp')

   		puts("INFO /// Number of connected iOS devices: " + udids.count.to_s)

   		first_destination = 'platform=iOS,id=' + udids.shift
   		first_destination = first_destination.gsub("\n","")

   		other_destinations = ""

   		# Generates string from all udids that remain.
   		udids.each { |udid|
   			other_destinations += "-destination " + "'platform=iOS,id=" + udid + "' "
   		}

   		other_destinations = other_destinations.gsub("\n", "")

   		scan(destination: first_destination, xcargs: other_destinations)
   	
   		sh("rm ./udids.temp")
   	end
   ```

7. Create a file called `.gitlab-ci.yml` in the root of the git repository and insert the following code:

   ```
   variables:
     LC_ALL: "en_US.UTF-8"
     LANG: "en_US.UTF-8"

   before_script:
     - bundle install

   stages:
     - test

   tests:
     stage: test
     tags:
       - android
     script:
       - bundle exec fastlane test
   ```

8. You will need to add the passphrase of your match certificates repo to your Gitlab Server. Create a new variable called MATCH_PASSWORD with the passphrase as value.

9. The project is now ready to be pushed. Keep in mind that the first time match gets executed it will need the user password for keychain access. So be prepared to enter it on your gitlab-runner computer.
