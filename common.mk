# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Common flags
common_c_includes := \
	external/oprofile \
	external/oprofile/libabi \
	external/oprofile/libdb \
	external/oprofile/libop \
	external/oprofile/libop++ \
	external/oprofile/libopt++ \
	external/oprofile/libpp \
	external/oprofile/libregex \
	external/oprofile/libutil \
	external/oprofile/libutil++

common_cflags := -DHAVE_CONFIG_H

# Common target flags
common_target_c_includes := $(common_c_includes)
common_target_cflags := $(common_cflags)

# Common host flags
# FIXME: Temporarily disabled until we get libiconv.a in the prebuilts.
#ifeq ($(strip $(TARGET_ARCH)),arm)
#toolchain := prebuilt/$(HOST_PREBUILT_TAG)/toolchain/arm-linux-androideabi-4.4.x
#HAVE_LIBBFD := true
#else
HAVE_LIBBFD := false
#endif

ifeq ($(HAVE_LIBBFD),true)
common_host_c_includes := $(common_c_includes) $(toolchain)/include

common_host_cflags = $(common_cflags) -fexceptions -DANDROID_HOST -DHAVE_XCALLOC
ifneq ($(HOST_OS),linux)
common_host_cflags += -DMISSING_MREMAP
endif

common_host_ldflags := -L$(toolchain)/lib
endif