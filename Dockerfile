FROM phusion/passenger-nodejs:1.0.1

# Fix permissions warning; https://github.com/meteor/meteor/issues/7959
ENV METEOR_ALLOW_SUPERUSER true

RUN apt-get update && \
	apt-get install --assume-yes apt-transport-https ca-certificates && \
	apt-get install --assume-yes --no-install-recommends build-essential bsdtar bzip2 curl git python

# Install Meteor
RUN curl https://install.meteor.com --output /tmp/install-meteor.sh && \
	# Replace tar with bsdtar in the install script; https://github.com/jshimko/meteor-launchpad/issues/39
	sed --in-place "s/tar -xzf.*/bsdtar -xf \"\$TARBALL_FILE\" -C \"\$INSTALL_TMPDIR\"/g" /tmp/install-meteor.sh && \
	sh /tmp/install-meteor.sh
