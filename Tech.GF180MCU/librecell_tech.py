from lclayout.layout.layers import *
from lclayout.writer.magic_writer import MagWriter
from lclayout.writer.lef_writer import LefWriter
from lclayout.writer.gds_writer import GdsWriter
from lclayout.writer.oasis_writer import OasisWriter

# This Tech file was created for 5V transistors for GlobalFoundries GF180MCU. There might be one layer missing for them. We could create additional cells for 3.3V and 6V, but that would change a lot of the DRC rules

# Physical size of one data base unit in meters.
# BUT GDS2 requires the database units to be in nanometers, and lclayout cannot convert to nanometers automatically yet
db_unit = 1e-9

# Lambda - how many db_units is 1 lambda?
grid = 5 # grid basis
um = 1000
nm = 1

# Scale transistor width.
transistor_channel_width_sizing = 1

# GDS2 layer numbers for final output.
my_diffusion = (22, 0) # = ndiffusion+pdiffusion
my_diffusion_label = (22, 0)
my_diffusion_pin = (22, 0)

my_nwell = (21, 0)
my_nwell_label = (21, 0)
my_nwell_pin = (21, 0)

my_pwell = (204, 0)

my_poly = (30, 0) # poly silicium for gates -> poly + ntransistor + ptransistor
my_poly_gate = (30, 0) # poly gates? Why do we have a second layer for gates?
my_poly_label = (30, 0)

my_mcon = (33, 0) 
my_metal1 = (34, 0)
my_metal1_label = (34, 0)
my_metal1_pin = (34, 0)
my_via1 = (35, 0)
my_metal2 = (36, 0)
my_metal2_label = (36, 0)
my_metal2_pin = (36, 0)
my_via2 = (38, 0)
my_metal3 = (42, 0)

my_abutment_box = (63, 0) # prBndry  ???

my_pplus = (31,0) # TAP.DRAWING
my_nplus = (32,0) # TAP.DRAWING

# lclayout internally uses its own layer numbering scheme.
# For the final output the layers can be remapped with a mapping
# defined in this dictioinary.
output_map = {
    l_ndiffusion: my_diffusion,
    l_pdiffusion: my_diffusion,
    l_nwell: my_nwell, # [my_nwell, my_nwell2],  # Map l_nwell to two output layers.
    l_pwell: my_pwell,  # Output layer for pwell. Uncomment this if needed. For instance for twin-well processes.
    l_poly: my_poly,
    l_poly_contact: my_mcon,
    l_pdiff_contact: my_mcon,
    l_ndiff_contact: my_mcon,
    l_metal1: my_metal1,
    l_metal1_label: my_metal1_label,
    l_metal1_pin: my_metal1_pin,
    l_via1: my_via1,
    l_metal2: my_metal2,
    l_metal2_label: my_metal2_label,
    l_metal2_pin: my_metal2_pin,
    l_abutment_box: my_abutment_box,
    l_pplus: my_pplus,
    l_nplus: my_nplus,
    l_border_vertical: (142, 1),
    l_border_horizontal: (142, 2),
}

# These are only the obstruction layers, only these layers will be generated into the OBS section of the LEF files
obstruction_layers = [
    l_poly_contact,
    l_pdiff_contact,
    l_ndiff_contact,
    l_metal1,
    l_via1,
    l_metal2,
]

output_map_magic = {
            l_nwell: 'nwell',
            l_pwell: 'pwell',
            l_via1: 'via1',
            l_poly: 'poly',
            l_abutment_box: ['abutment'],
            l_metal1: 'met1',
            l_metal2: 'met2',
            l_metal1_label: 'met1',
            l_metal2_label: 'met2',
            l_metal1_pin: 'met1',
            l_metal2_pin: 'met2',
            l_ndiffusion: 'ndiffusion',
            l_pdiffusion: 'pdiffusion',
            l_poly_contact: 'polycont',
            l_pdiff_contact: 'pdiffc',
            l_ndiff_contact: 'ndiffc',
            #l_nplus: 'nplus_s',
            #l_pplus: 'pplus_s'
}


# Define a list of output writers.
output_writers = [
    MagWriter(
        tech_name='gf180mcuC',
        scale_factor=0.2, # Scale all coordinates by this factor (rounded down to next integer).
        output_map=output_map_magic,
        magscale=[1,10]
    ),

    LefWriter(
        db_unit=1e-6, # LEF Fileformat always needs Microns
        obstruction_layers=obstruction_layers,
        output_map=output_map_magic,  # Not supported yet but will be soon
        use_rectangles_only=True,
        site="unit"
    ),

    GdsWriter(
        db_unit=db_unit,
        output_map=output_map
    ),

    OasisWriter(
        db_unit=db_unit,
        output_map=output_map
    )

]

# Define how layers can be used for routing.
# Example for a layer that can be used for horizontal and vertical tracks: {'MyLayer1' : 'hv'}
# Example for a layer that can be contacted but not used for routing: {'MyLayer2' : ''}
routing_layers = {
    l_ndiffusion: '', # Allow adding shapes on diffusion layer but without using it for routing. This is used to automatically add the necessary enclosure around contacts.
    l_pdiffusion: '', # Allow adding shapes on diffusion layer but without using it for routing. This is used to automatically add the necessary enclosure around contacts.
    l_poly: '',
    l_metal1: 'hv',
    l_metal2: 'hv',
}

# Minimum spacing rules for layer pairs.
min_spacing = {
    (l_ndiffusion, l_ndiffusion): 360*nm, # DF.3a for 5V
    #(l_ndiffusion, l_outline): 360/2*nm, # DF.3a for 5V
    (l_pdiffusion, l_ndiffusion): 360*nm, # DF.3a for 5V
    #(l_pdiffusion, l_outline): 360/2*nm, # DF.3a for 5V
    (l_pdiffusion, l_pdiffusion): 360*nm, # DF.3a for 5V
    (l_ndiffusion, l_poly_contact): 170*nm, # (CO.8)
    (l_pdiffusion, l_poly_contact): 170*nm, # (CO.8)
    (l_nwell, l_nwell): 740*nm, # NW.2a
    (l_nwell, l_pwell): 0*nm, # NW.4
    (l_pwell, l_pwell): 860*nm, # LPW.2b # If it would be the same potential, we could go down to 860*nm according to LPW.2b, if it is different potential we would have to go up to 1.7
    #(l_poly, l_ndiffusion): 300*nm, # PL.5b This is only needed when the poly isn't rectangular, and it doesn't mean the poly that is directly on top of diffusion
    #(l_poly, l_pdiffusion): 300*nm, # PL.5b
    (l_poly, l_poly): 240*nm, # PL.3a
    #(l_poly, l_outline): 240/2*nm, # PL.3a 
    (l_poly, l_pdiff_contact): 150*nm, # CO.7
    (l_poly, l_ndiff_contact): 150*nm, # CO.7
    (l_pdiff_contact, l_pdiff_contact): 250*nm, # CO.2a-CO.6   #!!! HIER WEITERMACHEN
    #(l_pdiff_contact, l_outline): 270/2*nm, # (difftap.3)
    (l_ndiff_contact, l_ndiff_contact): 250*nm, # CO.2a-CO.6
    #(l_ndiff_contact, l_outline): 270/2*nm, # (difftap.3)
    (l_pdiff_contact, l_ndiff_contact): 250*nm, # CO.2a-CO.6
    (l_metal1, l_metal1): 250*nm, # Mn.2a ! WARNING: Spacing to huge_met1 (>=10um) needs to be 300nm !
    #(l_metal1, l_outline): 170/2*nm, # (li.3) # !!!! WARNING: Spacing to huge_met1 (>=?nm) needs to be 280nm !
#    (l_metal1, l_border_vertical): 190*nm, # To move the VIAs at the right place
#    (l_metal2, l_border_vertical): 190*nm, # To move the VIAs at the right place

    (l_metal2, l_metal2): 280*nm, # Mn.2a
    # We need metal2 at the border for the power lanes, so we dont put border rules
    (l_via1, l_via1): 260*nm, # Vn.2a
    #(l_via1, l_outline): 190/2*nm, # (ct.2)
    #(l_via1, l_diff_contact): 2*l, # NO RULES FOR LICON-MCON spacing found
    #(l_via1, l_ndiffusion): 2*l, # NO RULES FOR MCON-DIFF spacing found
    #(l_via1, l_pdiffusion): 2*l, # NO RULES FOR MCON-DIFF spacing found
    (l_poly_contact, l_pdiff_contact): 280*nm, # CO.2b
    #(l_poly_contact, l_outline): 170/2*nm, # (licon.2)
    (l_poly_contact, l_ndiff_contact): 170*nm, # CO.2b
    (l_ndiffusion, l_pplus): 75*nm,
    (l_pdiffusion, l_nplus): 75*nm,
    (l_nplus, l_nplus): 400*nm, # NP.2
}

# Layer for the pins.
pin_layer = l_metal2 # lclayout.metal2 = sky130.metal1

# Power stripe layer
power_layer = [l_metal1, l_metal2] # lclayout.metal2 = sky130.metal1

# Layers that can be connected/merged without changing the schematic.
# This can be used to resolve spacing/notch violations by just filling the space.
connectable_layers = {l_nwell, l_pwell, l_poly, l_metal1}
# Width of the gate polysilicon stripe.
# is reused as the minimum_width for the l_poly layer
gate_length_nmos = 500*nm # PL.2
gate_length_pmos = 600*nm # PL.2

# Minimum length a polysilicon gate must overlap the silicon.
gate_extension = 220*nm # PL.4

# Minimum distance of active area to upper or lower boundary of the cell. Basically determines the y-offset of the transistors.
transistor_offset_y = 340*nm # !!! This likely needs to be tuned later on # The 150/2*nm might have to be removed

# Standard cell dimensions.
# A 'unit cell' corresponds to the dimensions of the smallest possible cell. Usually an inverter.
# `unit_cell_width` also corresponds to the pitch of the gates because gates are spaced on a regular grid.
unit_cell_width = 2*560*nm # (unit SITE) # measured from gf180mcu_fd_sc_mcu9t5v0__inv_1
unit_cell_height = 5040*nm # (unit SITE) # measured from gf180mcu_fd_sc_mcu9t5v0__inv_1

#assert unit_cell_height >= 16*um, "minimum 16um due to pwell width + nwell-pwell spacing"
# due to nwell size and spacing requirements routing_grid_pitch_y * 8 # * 8

# Routing pitch
routing_grid_pitch_x = unit_cell_width // 2 # // 4
routing_grid_pitch_y = 135*nm # unit_cell_height // 8 // 2

# Translate routing grid such that the bottom left grid point is at (grid_offset_x, grid_offset_y)
grid_offset_x = routing_grid_pitch_x
grid_offset_y = 0 # (routing_grid_pitch_y // 2 ) -10

# Width of power rail.
power_rail_width = 480*nm # compatible to SKY130 #  3*130*nm # decided by the standard cell library architect

# Minimum width of polysilicon gate stripes.
# It increases w and l from the spice netlist, so it must be width from the spice netlist
minimum_gate_width_nfet = 300*nm # PL.2
minimum_gate_width_pfet = 300*nm # PL.2

# Minimum width for pins.
minimum_pin_width = 220*nm 

# Width of routing wires.
wire_width = {
    l_ndiffusion: 150*nm, # (difftap.1)
    l_pdiffusion: 150*nm, # (difftap.2)
    l_poly: 150*nm,   # (poly.1a)
    l_metal1: 230*nm, # Mn.1
    l_metal2: 280*nm, # Mn.1
}

# Width of horizontal routing wires (overwrites `wire_width`).
wire_width_horizontal = {
    l_ndiffusion: 150*nm, # (difftap.1)
    l_pdiffusion: 150*nm, # (difftap.2)
    l_poly: 200*nm,   # PL.1
    l_metal1: 230*nm, # Mn.1
    l_metal2: 280*nm, # Mn.1
}

# Side lengths of vias (square shaped).
via_size = {
    l_poly_contact: 230*nm, # CO.1 + magic extensions 2*CO.6
    l_ndiff_contact: 230*nm, # CO.1 + magic extension 2*CO.6
    l_pdiff_contact: 230*nm, # CO.1 + magic extension 2*CO.6
    l_via1: 260*nm, # Vn.1
    #l_via2: 260*nm # Vn.1
}

# Minimum width rules.
minimum_width = {
    l_ndiffusion: 300*nm, # DF.1a
    l_pdiffusion: 300*nm, # DF.1a
    l_poly: 500*nm, # PL.2
    l_metal1: 230*nm, # Mn.1
    l_metal2: 280*nm, # Mn.1
    l_nwell: 900*nm, # NW.1a
    l_pwell: 740*nm, # LPW.1
    l_nplus: 400*nm # NP.1
}

# Minimum enclosure rules.
# Syntax: {(outer layer, inner layer): minimum enclosure, ...}
minimum_enclosure = {
    # Via enclosure
    (l_ndiffusion, l_ndiff_contact): 70*nm, # (CO.4)
    (l_pdiffusion, l_pdiff_contact): 70*nm, # (CO.4)
    (l_poly, l_poly_contact): 80*nm, # (licon.8a) !!! OR (licon.4) ?
    (l_metal1, l_pdiff_contact): 80*nm, # (li.5)
    (l_metal1, l_ndiff_contact): 80*nm, # (li.5)
    (l_metal1, l_poly_contact): 80*nm, # (li.5)
    (l_metal1, l_via1): 60*nm, # Vn.3
    (l_metal2, l_via1): 100*nm, # V1.4i

    # l_*well must overlap l_*diffusion
    (l_nwell, l_pdiffusion): 430*nm, # (DF.7)
    (l_pwell, l_ndiffusion): 430*nm, # (DF.7)
    (l_abutment_box, l_nwell): 0, # The nwell and pwell should not go beyond the abutment
    (l_abutment_box, l_pwell): 0,
    (l_nplus, l_ndiff_contact): 230*nm, # NP.5a  Implicitly encodes the size of well taps.
    (l_pplus, l_pdiff_contact): 230*nm, # PP.5a  Implicitly encodes the size of well taps.
    #(l_dnwell, l_pwell): 2500*nm,
}

# Minimum notch rules.
minimum_notch = {
    l_ndiffusion: 130*nm,
    l_pdiffusion: 130*nm,
    l_poly: 130*nm,
    l_metal1: 130*nm,
    l_metal2: 130*nm,
    l_nwell: 5*130*nm,
    l_pwell: 5*130*nm,
}

# Minimum area rules.
min_area = {
    l_ndiffusion: 0.2025 * um * um,
    l_pdiffusion: 0.2025 * um * um,
    l_metal1: 0.1444 * um * um ,# Mn.3
    #l_metal2: 0.1444 * um * um ,# Mn.3  - We don't need to enforce it here since that will be done by Openlane
    #l_nplus: 0.35 * um * um, #NP.8a
    #l_pplus: 0.35 * um * um, #PP.8a
}

# ROUTING #

# Cost for changing routing direction (horizontal/vertical).
# This will avoid creating zig-zag routings.
orientation_change_penalty = 100000

# Routing edge weights per data base unit.
weights_horizontal = {
    l_ndiffusion: 120000, # (mohms/square) taken from spreadsheet "Layer resistances and capacitances"
    l_pdiffusion: 197000, # (mohms/square)
    l_poly: 48200*10, # (mohms/square) # 10 to avoid routing
    l_metal1: 1280, # SKY130_Li1 Local Interconnect! (mohms/square)
    l_metal2: 125, # SKY130_Metal1
}
weights_vertical = {
    l_ndiffusion: 120000, # (mohms/square) taken from spreadsheet "Layer resistances and capacitances"
    l_pdiffusion: 197000, # (mohms/square)
    l_poly: 48200*10, # (mohms/square) # 10 to avoid routing
    l_metal1: 1280, # SKY130_Li1 Local Interconnect! (mohms/square)
    l_metal2: 125, # SKY130_Metal1
}

viafactor = 1

# Via weights.
via_weights = {
    (l_metal1, l_ndiffusion): 15000*viafactor, # LICON
    (l_metal1, l_pdiffusion): 15000*viafactor, # LICON
    (l_metal1, l_poly): 15000*viafactor, # LICON
    (l_metal1, l_metal2): 152000*viafactor, # MCON
    (l_metal1, l_nplus): 15000*viafactor, # Contact to Well Taps, the value doesn't matter
    (l_metal1, l_pplus): 15000*viafactor,

}

# Enable double vias between layers.
multi_via = {
    (l_metal1, l_poly): 1,
    (l_metal1, l_metal2): 1,
}

if( min_spacing[(l_pdiff_contact, l_pdiff_contact)] < min_spacing[(l_pdiffusion,l_pdiffusion)]+2*minimum_enclosure[(l_pdiffusion, l_pdiff_contact)]):
        newmin=min_spacing[(l_pdiffusion,l_pdiffusion)]+2*minimum_enclosure[(l_pdiffusion, l_pdiff_contact)]
        print("Minimum Spacing "+str(min_spacing[(l_pdiff_contact, l_pdiff_contact)])+" for pdiff_contact too small because of pdiffusion, minimum should be "+ str(newmin)+"(="+str(min_spacing[(l_pdiffusion,l_pdiffusion)])+"+2*"+str(minimum_enclosure[(l_pdiffusion, l_pdiff_contact)])+") Fixing minimum_spacing")
        min_spacing[(l_pdiff_contact, l_pdiff_contact)]=newmin

if( min_spacing[(l_ndiff_contact, l_ndiff_contact)] < min_spacing[(l_ndiffusion,l_ndiffusion)]+2*minimum_enclosure[(l_ndiffusion, l_ndiff_contact)]):
        newmin=min_spacing[(l_ndiffusion,l_ndiffusion)]+2*minimum_enclosure[(l_ndiffusion, l_ndiff_contact)]
        print("Minimum Spacing "+str(min_spacing[(l_ndiff_contact, l_ndiff_contact)])+" for ndiff_contact too small because of ndiffusion, minimum should be "+ str(newmin)+"(="+str(min_spacing[(l_ndiffusion,l_ndiffusion)])+"+2*"+str(minimum_enclosure[(l_ndiffusion, l_ndiff_contact)])+") Fixing minimum_spacing")
        min_spacing[(l_ndiff_contact, l_ndiff_contact)]=newmin

if( min_spacing[(l_pdiff_contact, l_ndiff_contact)] < min_spacing[(l_pdiffusion,l_ndiffusion)]+minimum_enclosure[(l_ndiffusion, l_ndiff_contact)]+minimum_enclosure[(l_pdiffusion, l_pdiff_contact)]):
        newmin=min_spacing[(l_pdiffusion,l_ndiffusion)]+minimum_enclosure[(l_ndiffusion, l_ndiff_contact)]+minimum_enclosure[(l_pdiffusion, l_pdiff_contact)]
        print("Minimum Spacing "+str(min_spacing[(l_ndiff_contact, l_ndiff_contact)])+" for pdiff_contact - ndiff_contact too small because of ndiffusion, minimum should be "+ str(newmin)+"(="+str(min_spacing[(l_pdiffusion,l_ndiffusion)])+"+"+str(minimum_enclosure[(l_ndiffusion, l_ndiff_contact)])+"+"+str(minimum_enclosure[(l_pdiffusion, l_pdiff_contact)])+") Fixing minimum_spacing")
        min_spacing[(l_pdiff_contact, l_ndiff_contact)]=newmin

if((l_poly_contact, l_poly_contact) in min_spacing and  min_spacing[(l_poly_contact, l_poly_contact)] < min_spacing[(l_poly,l_poly)]+2*minimum_enclosure[(l_poly, l_poly_contact)]):
        newmin=min_spacing[(l_poly,l_poly)]+2*minimum_enclosure[(l_poly, l_poly_contact)]
        print("Minimum Spacing "+str(min_spacing[(l_poly_contact, l_poly_contact)])+" for poly_contact too small because of polysilicon, minimum should be "+ str(newmin)+"(="+str(min_spacing[(l_poly,l_poly)])+"+"+str(minimum_enclosure[(l_poly, l_poly_contact)])+"+"+str(minimum_enclosure[(l_poly, l_poly_contact)])+") Fixing minimum_spacing")
        min_spacing[(l_poly_contact, l_poly_contact)]=newmin

if((l_poly_contact, l_poly_contact) in min_spacing and  min_spacing[(l_poly_contact, l_poly_contact)] < min_spacing[(l_metal1,l_metal1)]+2*minimum_enclosure[(l_metal1, l_poly_contact)]):
        newmin=min_spacing[(l_metal1,l_metal1)]+2*minimum_enclosure[(l_metal1, l_poly_contact)]
        print("Minimum Spacing "+str(min_spacing[(l_poly_contact, l_poly_contact)])+" for poly_contact too small because of local interconnect, minimum should be "+ str(newmin)+"(="+str(min_spacing[(l_metal1,l_metal1)])+"+"+str(minimum_enclosure[(l_metal1, l_poly_contact)])+"+"+str(minimum_enclosure[(l_metal1, l_poly_contact)])+") Fixing minimum_spacing")
        min_spacing[(l_poly_contact, l_poly_contact)]=newmin

#if( min_spacing[(l_via1, l_via1)] < min_spacing[(l_metal1,l_metal1)]+2*minimum_enclosure[(l_metal1, l_via1)]):
#        newmin=min_spacing[(l_metal1,l_metal1)]+2*minimum_enclosure[(l_metal1, l_via1)]
#        print("Minimum Spacing "+str(min_spacing[(l_via1, l_via1)])+" for via1 too small because of metal1, minimum should be "+ str(newmin)+"(="+str(min_spacing[(l_metal1,l_metal1)])+"+2*"+str(minimum_enclosure[(l_metal1, l_via1)])+") Fixing minimum_spacing")
#        min_spacing[(l_via1, l_via1)]=newmin

#if( min_spacing[(l_via1, l_via1)] < min_spacing[(l_metal2,l_metal2)]+2*minimum_enclosure[(l_metal2, l_via1)]):
#        newmin=min_spacing[(l_metal2,l_metal2)]+2*minimum_enclosure[(l_metal2, l_via1)]
#        print("Minimum Spacing "+str(min_spacing[(l_via1, l_via1)])+" for via1 too small because of metal2, minimum should be "+ str(newmin)+"(="+str(min_spacing[(l_metal2,l_metal2)])+"+2*"+str(minimum_enclosure[(l_metal2, l_via1)])+") Fixing minimum_spacing")
#        min_spacing[(l_via1, l_via1)]=newmin



    #(l_poly_contact, l_pdiff_contact): 170*nm, # (licon.2)
    #(l_poly_contact, l_ndiff_contact): 170*nm, # (licon.2)
#unit_cell_height=10
#routing_grid_pitch_y=4

#print("unit_cell_height: "+str(unit_cell_height))
#print("routing_grid_pitch_y: "+str(routing_grid_pitch_y))
middle=unit_cell_height//2
#print("Middle: "+str(middle))
gridpoints=1+unit_cell_height//routing_grid_pitch_y
#print("gridpoints: "+str(gridpoints))
odd=gridpoints &1
#print("odd: "+str(odd))

if odd==1:
    grid_offset_y=middle-((gridpoints-1)//2)*routing_grid_pitch_y
else:
    grid_offset_y=middle+routing_grid_pitch_y//2-(gridpoints//2)*routing_grid_pitch_y

print("grid_offset_y: "+str(grid_offset_y))
print("grid_offset_x: "+str(grid_offset_x))
print("routing_grid_pitch_x: "+str(routing_grid_pitch_x))

grid_ys = list(range(grid_offset_y, grid_offset_y + unit_cell_height, routing_grid_pitch_y))

#print("y_grid_before: "+str(grid_ys))
#grid_ys[2] += 110*nm
#grid_ys[-3] -= 110*nm
#grid_ys[14] -= 10*nm
#grid_ys[1] = 0
#grid_ys[-2] = unit_cell_height
#grid_ys.pop(-1)
#grid_ys.pop(0)
#print("y_grid_after: "+str(grid_ys))

#grid_xs = list(range(grid_offset_x, grid_offset_x + unit_cell_width, routing_grid_pitch_x))
#print("x_grid_after: "+str(grid_xs))
#print("grid_offset_x"+str(grid_offset_x))
#print("unit_cell_width"+str(unit_cell_width))
#print("routing_grid_pitch_x"+str(routing_grid_pitch_x))



#def powervias(unit_cell_width): 
#    return list(range(240*nm,unit_cell_width,480*nm))

#power_vias=powervias

