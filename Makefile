TARGET := iphone:clang:latest:14.0

TOOL_NAME = aster

aster_FILES = main.swift
aster_INSTALL_PATH = /usr/local/bin
aster_CODESIGN_FLAGS = -Sentitlements.plist

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tool.mk
