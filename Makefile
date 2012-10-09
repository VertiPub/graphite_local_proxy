default:
	@echo there is no default.  choose from:
	@egrep '^[^:    ]+:' Makefile

clean: # clean out some files and cruft.
	@rm -vf *~ 

# @rm -rf debian/$(pkg)-production debian/$(pkg) debian/$(pkg)-staging debian/$(pkg)-dev
# @rm -rf build dist packages
# @rm -fv debian/*.debhelper debian/*.substvars debian/files
# @rm -fv ../$(pkg)-$(pver)*
# @rm -fv ../$(pkg)-$(pver)* ../$(pkg)*.changes
# @rm -fv ../$(pkg)*.build ../$(pkg)*.dsc ../$(pkg)*.tar.gz

pkg: # make debian package.
	debuild -uc -us --lintian-opts --no-lintian

