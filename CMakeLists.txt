cmake_minimum_required(VERSION 3.16)
project(N8DMR VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

if(IOS)
    find_package(Qt6 6.5 REQUIRED COMPONENTS Core Gui Multimedia Network Quick QuickControls2)
else()
    find_package(Qt6 6.5 REQUIRED COMPONENTS Core Gui Multimedia Network Quick QuickControls2 SerialPort CorePrivate)
endif()

qt_standard_project_setup(REQUIRES 6.5)

set(app_icon_resource_windows "${CMAKE_CURRENT_SOURCE_DIR}/n8dmr.rc")
set(MACOSX_BUNDLE_ICON_FILE n8dmr.icns)
set(app_icon_macos "${CMAKE_CURRENT_SOURCE_DIR}/images/n8dmr.icns")
set_source_files_properties(${app_icon_macos} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")

qt_add_executable(N8DMR WIN32 MACOSX_BUNDLE
    CRCenc.cpp CRCenc.h
    DMRDefines.h
    Golay24128.cpp Golay24128.h
    M17Convolution.cpp M17Convolution.h
    M17Defines.h
    MMDVMDefines.h
    SHA256.cpp SHA256.h
    YSFConvolution.cpp YSFConvolution.h
    YSFFICH.cpp YSFFICH.h
    audioengine.cpp audioengine.h
    cbptc19696.cpp cbptc19696.h
    cgolay2087.cpp cgolay2087.h
    codec2/codebooks.cpp
    codec2/codec2.cpp
    codec2/codec2_api.h
    codec2/codec2_internal.h
    codec2/defines.h
    codec2/kiss_fft.cpp codec2/kiss_fft.h
    codec2/lpc.cpp codec2/lpc.h
    codec2/nlp.cpp codec2/nlp.h
    codec2/pack.cpp
    codec2/qbase.cpp codec2/qbase.h
    codec2/quantise.cpp codec2/quantise.h
    chamming.cpp chamming.h
    crs129.cpp crs129.h
    dcs.cpp dcs.h
    dmr.cpp dmr.h
    droidstar.cpp droidstar.h
    httpmanager.cpp httpmanager.h
    iax.cpp iax.h
    iaxdefines.h
    imbe_vocoder/aux_sub.cc imbe_vocoder/aux_sub.h
    imbe_vocoder/basic_op.h
    imbe_vocoder/basicop2.cc
    imbe_vocoder/ch_decode.cc imbe_vocoder/ch_decode.h
    imbe_vocoder/ch_encode.cc imbe_vocoder/ch_encode.h
    imbe_vocoder/dc_rmv.cc imbe_vocoder/dc_rmv.h
    imbe_vocoder/decode.cc imbe_vocoder/decode.h
    imbe_vocoder/dsp_sub.cc imbe_vocoder/dsp_sub.h
    imbe_vocoder/encode.cc imbe_vocoder/encode.h
    imbe_vocoder/globals.h
    imbe_vocoder/imbe.h
    imbe_vocoder/imbe_vocoder.cc imbe_vocoder/imbe_vocoder.h
    imbe_vocoder/math_sub.cc imbe_vocoder/math_sub.h
    imbe_vocoder/pe_lpf.cc imbe_vocoder/pe_lpf.h
    imbe_vocoder/pitch_est.cc imbe_vocoder/pitch_est.h
    imbe_vocoder/pitch_ref.cc imbe_vocoder/pitch_ref.h
    imbe_vocoder/qnt_sub.cc imbe_vocoder/qnt_sub.h
    imbe_vocoder/rand_gen.cc imbe_vocoder/rand_gen.h
    imbe_vocoder/sa_decode.cc imbe_vocoder/sa_decode.h
    imbe_vocoder/sa_encode.cc imbe_vocoder/sa_encode.h
    imbe_vocoder/sa_enh.cc imbe_vocoder/sa_enh.h
    imbe_vocoder/tbls.cc imbe_vocoder/tbls.h
    imbe_vocoder/typedef.h
    imbe_vocoder/typedefs.h
    imbe_vocoder/uv_synt.cc imbe_vocoder/uv_synt.h
    imbe_vocoder/v_synt.cc imbe_vocoder/v_synt.h
    imbe_vocoder/v_uv_det.cc imbe_vocoder/v_uv_det.h
    m17.cpp m17.h
    main.cpp
    mbe/ambe.cpp
    mbe/ambe2.cc mbe/ambe2.h
    mbe/ambe3600x2400.cpp
    mbe/ambe3600x2450.cpp
    mbe/analysis.cc mbe/analysis.h
    mbe/api.cc
    mbe/codebook.cc mbe/codebook.h
    mbe/codebook_set.cc
    mbe/constants.h
    mbe/cosine.cc
    mbe/decoder.cc mbe/decoder.h
    mbe/decoder_api.cc
    mbe/decoder_options.cc mbe/decoder_options.h
    mbe/decoder_synth.cc mbe/decoder_synth.h
    mbe/decoder_tables.cc mbe/decoder_tables.h
    mbe/dequant.cc mbe/dequant.h
    mbe/enc_analysis.cc
    mbe/encoder.cc mbe/encoder.h
    mbe/encoder_api.cc
    mbe/enc_pitch_net.cc
    mbe/enc_tables.h
    mbe/enhance.cc mbe/enhance.h
    mbe/fastmath.cc mbe/fastmath.h
    mbe/fec.cc mbe/fec.h
    mbe/fft.cc mbe/fft.h
    mbe/frame.cc mbe/frame.h
    mbe/frame_layout.cc
    mbe/golay.cc
    mbe/halfrate.h
    mbe/history.h
    mbe/mbevocoder.cpp mbe/mbevocoder.h
    mbe/numeric.h
    mbe/options.cc
    mbe/options.h
    mbe/pitch.cc mbe/pitch.h
    mbe/shape_quantizer.cc
    mbe/shape_quantizer.h
    mbe/tables.h
    mbe/vocoder_tables.h
    mode.cpp mode.h
    nxdn.cpp nxdn.h
    p25.cpp p25.h
    ref.cpp ref.h
    xrf.cpp xrf.h
    ysf.cpp ysf.h
    ${app_icon_resource_windows}
    ${app_icon_macos}
)

qt_add_qml_module(N8DMR
    URI N8DMRApp
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES MainTab.qml
    QML_FILES SettingsTab.qml
    QML_FILES LogTab.qml
    QML_FILES HostsTab.qml
    QML_FILES AboutTab.qml
)

qt_add_resources(N8DMR n8dmr_branding PREFIX "/" FILES assets/n8schicht-icon.png)

execute_process(
    COMMAND git rev-parse --short HEAD
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    OUTPUT_VARIABLE VERSION_NUMBER
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

target_compile_definitions(N8DMR PRIVATE
    QT_DEPRECATED_WARNINGS
    VERSION_NUMBER="${VERSION_NUMBER}"
)

target_link_libraries(N8DMR PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Multimedia
    Qt::Network
    Qt::Quick
    Qt::QuickControls2
)

if(UNIX AND NOT IOS)
    target_link_libraries(N8DMR PRIVATE
        Qt::SerialPort
    )
endif()

if(WIN32)
    target_link_libraries(N8DMR PRIVATE
        Qt::SerialPort
        ws2_32
    )
    #add_compile_options(-static --enable-stdcall-fixup)
endif()

if(UNIX)
    target_link_libraries(N8DMR PRIVATE
        dl
    )
endif()

if(IOS)
   set(CMAKE_OSX_DEPLOYMENT_TARGET "18.0")
   target_sources(N8DMR PUBLIC
      iosaudiosession.mm
  )
endif()
if(APPLE)
    set(MY_BUNDLE_ID "de.die-n8schicht.n8dmr")
    set_target_properties(N8DMR PROPERTIES
        MACOSX_BUNDLE_GUI_IDENTIFIER "${MY_BUNDLE_ID}"
        XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "${MY_BUNDLE_ID}"
        MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist
        XCODE_ATTRIBUTE_INFOLIST_FILE ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist
    )
    target_link_libraries(N8DMR PRIVATE
        "-framework AVFoundation"
    )
    qt_add_ios_ffmpeg_libraries(N8DMR)
endif()

if(ANDROID)
    target_link_libraries(N8DMR PRIVATE Qt6::CorePrivate)
    include(~/Android/Sdk/android_openssl/android_openssl.cmake)
    add_android_openssl_libraries(N8DMR)
    target_sources(N8DMR PUBLIC
        androidserialport.cpp androidserialport.h
    )

    set_target_properties(N8DMR PROPERTIES
       QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
       QT_ANDROID_VERSION_CODE 98
       #QT_ANDROID_MIN_SDK_VERSION 31
    )
endif()

if(NOT IOS)
    target_sources(N8DMR PUBLIC
        serialambe.cpp serialambe.h
        serialmodem.cpp serialmodem.h
    )
endif()

if(FALSE) # set TRUE for flite
    target_compile_definitions(N8DMR PRIVATE
        USE_FLITE
    )
    target_link_libraries(N8DMR PRIVATE
        asound
        flite_cmu_us_awb
        flite_cmu_us_kal16
        flite_cmu_us_rms
        flite_cmu_us_slt
        flite_cmulex
        flite_usenglish
        flite
    )
endif()

if(FALSE) # set TRUE for md380_vocoder
    target_compile_definitions(N8DMR PRIVATE
        USE_MD380_VOCODER
    )
    target_link_libraries(N8DMR PRIVATE
        md380_vocoder
    )
endif()

install(TARGETS N8DMR
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if(WIN32)
    qt_generate_deploy_app_script(
        TARGET N8DMR
        OUTPUT_SCRIPT deploy_script
        NO_UNSUPPORTED_PLATFORM_ERROR
    )
    install(SCRIPT ${deploy_script})
endif()

if(UNIX AND NOT APPLE)
    install(FILES packaging/n8dmr.desktop DESTINATION share/applications)
    install(FILES images/n8dmr-icon.png
        DESTINATION share/icons/hicolor/192x192/apps
        RENAME n8dmr.png)
endif()
