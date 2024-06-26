# vsim -do run.do 开始运行
quit -sim

# 编译文件
vlog *.sv

# 执行模拟
vsim cpu_tb -voptargs=+acc 

# 打开波形窗口
view wave

# 添加波形 加载所有的波形
add wave cpu_tb/cpu_inst/*
add wave cpu_tb/cpu_inst/Regs/*
# run 
run 400ns

