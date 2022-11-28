#!/bin/python3
import glob
import re

def main():
    cmd_file = 'CharLib.cmd'
    gen_lib_common("GF180MCUC", cmd_file)
    gen_char_cond("5", cmd_file)
    for cell in glob.glob('*.cell'):
        sp= re.sub('\.cell$', '.sp', cell)
        cellname = re.sub('\.cell$','',cell) 
        inputs=['A','B']
        outputs=['Y']
        functions=[]
        cellfh = open(cell, 'r')
        for line in cellfh.readlines():
            line=line.rstrip()
            if '.inputs ' in line:
                inputs=line[8:].split(' ')
            if '.outputs ' in line:
                outputs=line[9:].split(' ')
        cellfh.close()
        verilogfh = open( re.sub('\.cell$', '.truthtable.v', cell))
        for line in verilogfh.readline().split(':')[1:]:
            functions.append(re.sub(' ','',re.sub('\|\|','|',re.sub('\&\&','&',re.sub('function','',line)))))
        verilogfh.close()
        gen_comb("GF180MCUC", cmd_file, cellname,   cellname,   inputs, outputs, functions, '1', sp)
#    gen_comb("OSU350", cmd_file, "NAND2X1", "NAND2", ['A','B'],         ['Y'], ['Y=!(A&B)'],     '1', 'NETLIST/NAND2X1.spi')
#    gen_comb("OSU350", cmd_file, "NAND3X1", "NAND3", ['A','B','C'],     ['Y'], ['Y=!(A&B&C)'],   '1', 'NETLIST/NAND3X1.spi')
#    gen_comb("OSU350", cmd_file, "NAND4X1", "NAND4", ['A','B','C','D'], ['Y'], ['Y=!(A&B&C&D)'], '1', 'NETLIST/NAND4X1.spi')
#    gen_comb("OSU350", cmd_file, "NOR2X1",  "NOR2",  ['A','B'],         ['Y'], ['Y=!(A|B)'],     '1', 'NETLIST/NOR2X1.spi')
#    gen_comb("OSU350", cmd_file, "NOR3X1",  "NOR3",  ['A','B','C'],     ['Y'], ['Y=!(A|B|C)'],   '1', 'NETLIST/NOR3X1.spi')
#    gen_comb("OSU350", cmd_file, "NOR4X1",  "NOR4",  ['A','B','C','D'], ['Y'], ['Y=!(A|B|C|D)'], '1', 'NETLIST/NOR4X1.spi')
#    gen_comb("OSU350", cmd_file, "AND2X1",  "AND2",  ['A','B'],         ['Y'],  ['Y=(A&B)'],       '1', 'NETLIST/AND2X1.spi')
#    gen_comb("OSU350", cmd_file, "AND3X1",  "AND3",  ['A','B','C'],     ['Y'],  ['Y=(A&B&C)'],     '1', 'NETLIST/AND3X1.spi')
#    gen_comb("OSU350", cmd_file, "AND4X1",  "AND4",  ['A','B','C','D'], ['Y'],  ['Y=(A&B&C&D)'],   '1', 'NETLIST/AND4X1.spi')
#    gen_comb("OSU350", cmd_file, "OR2X1",   "OR2",   ['A','B'],         ['Y'],  ['Y=(A|B)'],       '1', 'NETLIST/OR2X1.spi')
#    gen_comb("OSU350", cmd_file, "OR3X1",   "OR3",   ['A','B','C'],     ['Y'],  ['Y=(A|B|C)'],     '1', 'NETLIST/OR3X1.spi')
#    gen_comb("OSU350", cmd_file, "OR4X1",   "OR4",   ['A','B','C','D'], ['Y'],  ['Y=(A|B|C|D)'],   '1', 'NETLIST/OR4X1.spi')
#    gen_comb("OSU350", cmd_file, "AOI21X1", "AOI21", ['A','B','C'],         ['Y'], ['Y=!(C|(A&B))'],      '1', 'NETLIST/AOI21X1.spi')
#    gen_comb("OSU350", cmd_file, "AOI22X1", "AOI22", ['A','B','C','D'],   ['Y'], ['Y=!((C&D)|(A&B))'],'1', 'NETLIST/AOI22X1.spi')
#    gen_comb("OSU350", cmd_file, "OAI21X1", "OAI21", ['A1','A2','B'],         ['YB'], ['YB=!(B&(A1|A2))'],      '1', 'NETLIST/OAI21X1.spi')
#    gen_comb("OSU350", cmd_file, "OAI22X1", "OAI22", ['A1','A2','B1','B2'],   ['YB'], ['YB=!((B1|B2)&(A1|A2))'],'1', 'NETLIST/OAI22X1.spi')
#    gen_comb("OSU350", cmd_file, "AO21X1",  "AO21",  ['A1','A2','B'],         ['Y'],  ['Y=(B|(A1&A2))'],        '1', 'NETLIST/AO21X1.spi')
#    gen_comb("OSU350", cmd_file, "AO22X1",  "AO22",  ['A1','A2','B1','B2'],   ['Y'],  ['Y=((B1&B2)|(A1&A2))'],  '1', 'NETLIST/AO22X1.spi')
#    gen_comb("OSU350", cmd_file, "OA21X1",  "OA21",  ['A1','A2','B'],         ['Y'],  ['Y=(B&(A1|A2))'],        '1', 'NETLIST/OA21X1.spi')
#    gen_comb("OSU350", cmd_file, "OA22X1",  "OA22",  ['A1','A2','B1','B2'],   ['Y'],  ['Y=((B1|B2)&(A1|A2))'],  '1', 'NETLIST/OA22X1.spi')
#    gen_comb("OSU350", cmd_file, "XOR2X1",  "XOR2",  ['A','B'],               ['Y'],  ['Y=((A&!B)&(!A&B))'],    '1', 'NETLIST/XOR2X1.spi')
#    gen_comb("OSU350", cmd_file, "XNOR2X1", "XNOR2", ['A','B'],               ['Y'],  ['Y=((!A&!B)&(A&B))'],    '1', 'NETLIST/XNOR2X1.spi')
#    gen_seq ("OSU350", cmd_file, "DFFX1", "DFF_PCPU", ['DATA','CLK'], ['Q'], ['Q','QN'], ['Q=IQ','QN=IQN'], '1', 'NETLIST/DFFX1.spi')
#    gen_seq ("OSU350", cmd_file, "DFFSR", "DFF_PCPU_NRNS", ['DATA','CLK','NSET','NRST'], ['Q'], ['IQ','IQN'], ['Q=IQ','QN=IQN'], '1', 'NETLIST/DFFARASX1.spi')
    exit_CharLib(cmd_file)

def gen_lib_common(name, cmd_file):
    with open(cmd_file,'w') as f:
        outlines = []
        outlines.append("# common settings for library\n")
        outlines.append("set_lib_name         "+str(name)+"\n")
        outlines.append("set_dotlib_name      "+str(name)+".lib\n")
        outlines.append("set_verilog_name     "+str(name)+".v\n")
        outlines.append("set_cell_name_suffix "+str(name)+"_\n")
        outlines.append("set_cell_name_prefix _V1\n")
        outlines.append("set_voltage_unit V\n")
        outlines.append("set_capacitance_unit pF\n")
        outlines.append("set_resistance_unit Ohm\n")
        outlines.append("set_current_unit mA\n")
        outlines.append("set_leakage_power_unit pW \n")
        outlines.append("set_energy_unit fJ \n")
        outlines.append("set_time_unit ns\n")
        outlines.append("set_vdd_name VDD\n")
        outlines.append("set_vss_name VSS\n")
        outlines.append("set_pwell_name VPW\n")
        outlines.append("set_nwell_name VNW\n")
        f.writelines(outlines)
    f.close()

def gen_char_cond(vdd, cmd_file):
    with open(cmd_file,'a') as f:
        outlines = []
        outlines.append("# characterization conditions \n")
        outlines.append("set_process typ\n")
        outlines.append("set_temperature 25\n")
        outlines.append("set_vdd_voltage "+str(vdd)+"\n")
        outlines.append("set_vss_voltage 0\n")
        outlines.append("set_pwell_voltage 0\n")
        outlines.append("set_nwell_voltage "+str(vdd)+"\n")
        outlines.append("set_logic_threshold_high 0.8\n")
        outlines.append("set_logic_threshold_low 0.2\n")
        outlines.append("set_logic_high_to_low_threshold 0.5\n")
        outlines.append("set_logic_low_to_high_threshold 0.5\n")
        outlines.append("set_work_dir work\n")
        outlines.append("set_simulator /usr/bin/ngspice \n")
#        outlines.append("set_simulator /cad/synopsys/hspice/P-2019.06-1/hspice/bin/hspice -CC -port 2990wx:25000 -i \n")
        outlines.append("set_run_sim true\n")
#        outlines.append("set_run_sim false\n")
        outlines.append("set_mt_sim true\n")
        outlines.append("set_supress_message false\n")
        outlines.append("set_supress_sim_message false\n")
        outlines.append("set_supress_debug_message true\n")
        outlines.append("set_energy_meas_low_threshold 0.01\n")
        outlines.append("set_energy_meas_high_threshold 0.99\n")
        outlines.append("set_energy_meas_time_extent 10\n")
        outlines.append("set_operating_conditions PVT_3P5V_25C\n")
        outlines.append("# initialize workspace\n")
        outlines.append("initialize\n")
        f.writelines(outlines)
    f.close()

def gen_comb(target, cmd_file, cell_name, logic, inports, outports, funcs, area, netlist):
    with open(cmd_file,'a') as f:
        outlines = []
        outlines.append("\n")
        outlines.append("## add circuit\n")
        line_add_cell = 'add_cell -n '+str(cell_name)+' -l '+str(logic)+' -i '
        for w1 in inports:
            line_add_cell += str(w1)+' '
        line_add_cell += '-o '
        for w1 in outports:
            line_add_cell += str(w1)+' '
        line_add_cell += '-f '
        for w1 in funcs:
            line_add_cell += str(w1)+' '
        line_add_cell += '\n'
        outlines.append(line_add_cell)
#        outlines.append("add_slope {0.1 0.4 1.6 6.4} \n")
#        outlines.append("add_load  {0.01 0.04 0.16 0.64} \n")
        if(target == "ROHM180"):
            outlines.append("add_slope {0.1 0.7 4.9} \n")
            outlines.append("add_load  {0.01 0.1 1.0} \n")
            #outlines.append("add_slope {0.1 } \n")
            #outlines.append("add_load  {0.01 } \n")
        elif(target == "OSU350"):
            #outlines.append("add_slope {0.1 0.7 4.9} \n")
            #outlines.append("add_load  {0.01 0.07 0.49} \n")
            outlines.append("add_slope {0.1 4.9} \n")
            outlines.append("add_load  {0.01 0.49} \n")
        elif(target == "GF180MCUC"):
            #outlines.append("add_slope {0.1 0.7 4.9} \n")
            #outlines.append("add_load  {0.01 0.07 0.49} \n")
            outlines.append("add_slope {0.1 4.9} \n")
            outlines.append("add_load  {0.01 0.49} \n")
        else:
            print("target is not registered!\n")
        line_add_area = 'add_area '+str(area)+'\n'
        outlines.append(line_add_area)
        line_add_netlist = 'add_netlist '+str(netlist)+'\n'
        outlines.append(line_add_netlist)
        if(target == "ROHM180"):
            outlines.append("add_model rohmlib/model_rohm180.sp\n")
        elif(target == "OSU350"):
            outlines.append("add_model NETLIST/model.sp\n")
        elif(target == "GF180MCUC"):
            outlines.append("add_model NETLIST/model.sp\n")
        else:
            print("target is not registered!\n")
        outlines.append("add_simulation_timestep auto\n")
        outlines.append("characterize\n")
        outlines.append("export\n")
        outlines.append("\n")
        f.writelines(outlines)
    f.close()

def gen_seq(target, cmd_file, cell_name, logic, inports, outports, storage, funcs, area, netlist):
    with open(cmd_file,'a') as f:
        outlines = []
        outlines.append("## add circuit\n")
        line_add_flop = 'add_flop -n '+str(cell_name)+' -l '+str(logic)
        if((logic == 'DFF_PCPU_NRNS')or(logic == 'DFF_PCNU_NRNS')or(logic == 'DFF_NCPU_NRNS')or(logic == 'DFF_NCNU_NRNS')):
            line_add_flop += ' -i '+str(inports[0])+' -c '+str(inports[1])+' -s '+str(inports[2])+' -r '+str(inports[3]) 
        elif((logic == 'DFF_PCPU_NR')or(logic == 'DFF_PCNU_NR')or(logic == 'DFF_NCPU_NR')or(logic == 'DFF_NCNU_NR')):
            line_add_flop += ' -i '+str(inports[0])+' -c '+str(inports[1])+' -r '+str(inports[2]) 
        elif((logic == 'DFF_PCPU_NS')or(logic == 'DFF_PCNU_NS')or(logic == 'DFF_NCPU_NS')or(logic == 'DFF_NCNU_NS')):
            line_add_flop += ' -i '+str(inports[0])+' -c '+str(inports[1])+' -s '+str(inports[2])
        elif((logic == 'DFF_PCPU')or(logic == 'DFF_PCNU')or(logic == 'DFF_NCPU')or(logic == 'DFF_NCNU')):
            line_add_flop += ' -i '+str(inports[0])+' -c '+str(inports[1])
        else:
            print("function not matched!\n")
        line_add_flop += ' -o '
        for w1 in outports:
            line_add_flop += str(w1)+' '
        line_add_flop += '-q '
        for w1 in storage:
            line_add_flop += str(w1)+' '
        line_add_flop += '-f '
        for w1 in funcs:
            line_add_flop += str(w1)+' '
        line_add_flop += '\n'
        outlines.append(line_add_flop)
        if(target == "ROHM180"):
            outlines.append("add_slope {0.1 0.7 4.9} \n")
            outlines.append("add_load  {0.01 0.1 1.0} \n")
            #outlines.append("add_slope {0.1 } \n")
            #outlines.append("add_load  {0.01 } \n")
        elif(target == "OSU350"):
            #outlines.append("add_slope {0.1 0.7 4.9} \n")
            #outlines.append("add_load  {0.01 0.07 0.49} \n")
            outlines.append("add_slope {0.1 4.9} \n")
            outlines.append("add_load  {0.01 0.49} \n")
        else:
            print("target is not registered!\n")
        outlines.append("add_clock_slope auto \n")
        line_add_area = 'add_area '+str(area)+'\n'
        outlines.append(line_add_area)
        line_add_netlist = 'add_netlist '+str(netlist)+'\n'
        outlines.append(line_add_netlist)
        if(target == "ROHM180"):
            outlines.append("add_model rohmlib/model_rohm180.sp\n")
        elif(target == "OSU350"):
            outlines.append("add_model NETLIST/model.sp\n")
        else:
            print("target is not registered!\n")
        outlines.append("add_simulation_timestep auto\n")
        outlines.append("add_simulation_setup_auto\n")
        outlines.append("add_simulation_hold_auto\n")
        #outlines.append("add_simulation_setup 0.1\n")
        #outlines.append("add_simulation_hold 0.1\n")
        outlines.append("characterize\n")
        outlines.append("export\n")
        f.writelines(outlines)
    f.close()

def exit_CharLib(cmd_file):
    with open(cmd_file,'a') as f:
        outlines = []
        outlines.append("exit\n")
        f.writelines(outlines)
    f.close()

if __name__ == '__main__':
    main()

