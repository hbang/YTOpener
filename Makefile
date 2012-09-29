include theos/makefiles/common.mk

TWEAK_NAME = YTOpener
YTOpener_FILES = Tweak.xm
YTOpener_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

#SUBPROJECTS = prefs
#include $(THEOS_MAKE_PATH)/aggregate.mk
