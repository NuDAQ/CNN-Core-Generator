<AutoPilot:project xmlns:AutoPilot="com.autoesl.autopilot.project" top="cnn_core" name="cnn_core_streaming_prj">
    <files>
        <file name="../../firmware/weights" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../../tb/compare_runner.cpp" sc="0" tb="1" cflags="-std=c++14 -I../../. -I../../firmware -DHLS_STREAMING_2X_INPUT -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="firmware/cnn_core.cpp" sc="0" tb="false" cflags="-std=c++14 -I. -Ifirmware" csimflags="" blackbox="false"/>
    </files>
    <solutions>
        <solution name="solution1" status=""/>
    </solutions>
    <Simulation argv="">
        <SimFlow name="csim" setup="false" optimizeCompile="false" clean="false" ldflags="" mflags=""/>
    </Simulation>
</AutoPilot:project>

