<AutoPilot:project xmlns:AutoPilot="com.autoesl.autopilot.project" projectType="C/C++" name="cnn_core_prj" top="cnn_core">
    <solutions>
        <solution name="solution1" status=""/>
    </solutions>
    <Simulation argv="">
        <SimFlow name="csim" setup="false" optimizeCompile="false" clean="false" ldflags="" mflags=""/>
    </Simulation>
    <files>
        <file name="../../tb_data" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../../firmware/weights" sc="0" tb="1" cflags="-Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../../cnn_core_test.cpp" sc="0" tb="1" cflags="-std=c++0x -DRTL_SIM -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="firmware/cnn_core.cpp" sc="0" tb="false" cflags="-std=c++0x" csimflags="" blackbox="false"/>
    </files>
</AutoPilot:project>

