
SCMFILES = hubeny.scm

MAKE_GENERATED = hubeny.scm config.log

all : $(SCMFILES)

hubeny.scm : hubeny.scm.in
	$(GOSH) ./prebuild.scm

clean :

distclean : clean
	rm -rf $(MAKE_GENERATED)

maintainer-clean : distclean
