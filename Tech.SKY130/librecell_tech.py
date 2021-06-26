from lclayout.layout.layers import *
from lclayout.writer.magic_writer import MagWriter
from lclayout.writer.lef_writer import LefWriter
from lclayout.writer.gds_writer import GdsWriter
from lclayout.writer.oasis_writer import OasisWriter

# Physical size of one data base unit in meters.
# BUT GDS2 requires the database units to be in nanometers, and lclayout cannot convert to nanometers automatically yet
db_unit = 1e-9

# Lambda - how many db_units is 1 lambda?
l = 55  # unused
grid = 5 # grid basis
um = 1000
nm = 1

# Scale transistor width.
transistor_channel_width_sizing = 1

# GDS2 layer numbers for final output.
my_diffusion = (65, 20) # = ndiffusion+pdiffusion
my_diffusion_label = (65, 6)
my_diffusion_pin = (65, 16)
#my_pdiffusion = (1, 7) -> my_diffusion

my_nwell = (64, 20)
my_nwell_label = (64, 5)
my_nwell_pin = (64, 16) #  (64, 0) !!! both GDS definitions were found in the Skywater documentation, please check which are correct.

# my_pwell = (64, 13) # This layer is only used for resistors, which we dont need here

my_poly = (66, 20) # poly silicium for gates -> poly + ntransistor + ptransistor
my_poly_gate = (66, 9) # poly gates? Why do we have a second layer for gates?
my_poly_label = (66, 5)

my_licon1 = (66, 44) # licon1 is used to contact both polysilicon and diffusion in SKY130.
my_li1 = (67, 20) # "Local Interconnect"  (like the first metal layer)
my_li1_label = (67, 5)
my_li1_pin = (67, 16)

my_mcon = (67, 44) # connecting li1 to metal1
my_metal1 = (68, 20)
my_metal1_label = (68, 5)
my_metal1_pin = (68, 16)
my_via1 = (68, 44)
my_metal2 = (69, 20)
my_metal2_label = (69, 5)
my_metal2_pin = (69, 16)
my_abutment_box = (235, 4) # prBndry  ???
#my_outline = (235, 5) # 

my_pplus = (65,44) # TAP.DRAWING
my_nplus = (65,44) # TAP.DRAWING

# lclayout internally uses its own layer numbering scheme.
# For the final output the layers can be remapped with a mapping
# defined in this dictioinary.
output_map = {
    l_ndiffusion: my_diffusion,
    l_pdiffusion: my_diffusion,
    l_nwell: my_nwell, # [my_nwell, my_nwell2],  # Map l_nwell to two output layers.
    #l_pwell: my_pwell,  # Output layer for pwell. Uncomment this if needed. For instance for twin-well processes.
    l_poly: my_poly,
    l_poly_contact: my_licon1,
    l_pdiff_contact: my_licon1,
    l_ndiff_contact: my_licon1,
    l_metal1: my_li1, # Metal1 from lclayout gets li1 from SKY130
    l_metal1_label: my_li1_label,
    l_metal1_pin: my_li1_pin,
    l_via1: my_mcon,
    l_metal2: my_metal1, # Metal2 from lclayout gets met1 from SKY130
    l_metal2_label: my_metal1_label,
    l_metal2_pin: my_metal1_pin,
    l_abutment_box: my_abutment_box,
    #l_outline: my_outline,
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
    l_metal1, # Metal1 from lclayout gets li1 from SKY130
    l_via1,
    l_metal2, # Metal2 from lclayout gets met1 from SKY130
]

output_map_magic = {
            l_nwell: 'nwell',
            l_via1: 'viali',
            l_poly: 'poly',
            l_abutment_box: ['abutment'],
            l_metal1: 'li1',
            l_metal2: 'met1',
            l_metal1_label: 'li1',
            l_metal2_label: 'met1',
            l_metal1_pin: 'li1',
            l_metal2_pin: 'met1',
            l_ndiffusion: 'ndiffusion',
            l_pdiffusion: 'pdiffusion',
            l_poly_contact: 'polycont',
            l_pdiff_contact: 'pdiffc',
            l_ndiff_contact: 'ndiffc',
            l_nplus: 'allnactivetap',
            l_pplus: 'allpactivetap'
}


# Define a list of output writers.
output_writers = [
    MagWriter(
        tech_name='sky130A',
        scale_factor=0.2, # Scale all coordinates by this factor (rounded down to next integer).
        output_map=output_map_magic
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
    (l_ndiffusion, l_ndiffusion): 270*nm, # (difftap.3)
    #(l_ndiffusion, l_outline): 270/2*nm, # (difftap.3)
    (l_pdiffusion, l_ndiffusion): 270*nm, # (difftap.3)
    #(l_pdiffusion, l_outline): 270/2*nm, # (difftap.3)
    (l_pdiffusion, l_pdiffusion): 270*nm, # (difftap.3)
    (l_ndiffusion, l_poly_contact): 190*nm, # (licon.14)
    (l_pdiffusion, l_poly_contact): 190*nm, # (licon.14)
    (l_nwell, l_nwell): 1270*nm, # (nwell.2a)
    (l_nwell, l_pwell): 250*nm, # p_well not needed for SKY130, but lclayout uses it for sizing the wells!
    (l_pwell, l_pwell): 1270*nm, # p_well not needed for SKY130
    (l_poly, l_ndiffusion): 75*nm, # (poly.4)
    (l_poly, l_pdiffusion): 75*nm, # (poly.4)
    (l_poly, l_poly): 210*nm, # (poly.2)
    #(l_poly, l_outline): 210/2*nm, # (poly.2) 
    (l_poly, l_pdiff_contact): 155*nm, # 55*nm # (licon.11)
    (l_poly, l_ndiff_contact): 155*nm, # 55*nm # (licon.11)
    (l_pdiff_contact, l_pdiff_contact): 270*nm, # (difftap.3)
    #(l_pdiff_contact, l_outline): 270/2*nm, # (difftap.3)
    (l_ndiff_contact, l_ndiff_contact): 270*nm, # (difftap.3)
    #(l_ndiff_contact, l_outline): 270/2*nm, # (difftap.3)
    (l_pdiff_contact, l_ndiff_contact): 270*nm, # (difftap.3)
    (l_metal1, l_metal1): 170*nm, # (li.3) # !!!! WARNING: Spacing to huge_met1 (>=?nm) needs to be 280nm !
    #(l_metal1, l_outline): 170/2*nm, # (li.3) # !!!! WARNING: Spacing to huge_met1 (>=?nm) needs to be 280nm !
#    (l_metal1, l_border_vertical): 190*nm, # To move the VIAs at the right place
#    (l_metal2, l_border_vertical): 190*nm, # To move the VIAs at the right place

    (l_metal2, l_metal2): 140*nm, # (m1.2) # huge_met2
    # We need metal2 at the border for the power lanes, so we dont put border rules
    (l_via1, l_via1): 190*nm, # (ct.2)
    #(l_via1, l_outline): 190/2*nm, # (ct.2)
    #(l_via1, l_diff_contact): 2*l, # NO RULES FOR LICON-MCON spacing found
    #(l_via1, l_ndiffusion): 2*l, # NO RULES FOR MCON-DIFF spacing found
    #(l_via1, l_pdiffusion): 2*l, # NO RULES FOR MCON-DIFF spacing found
    (l_poly_contact, l_pdiff_contact): 170*nm, # (licon.2)
    #(l_poly_contact, l_outline): 170/2*nm, # (licon.2)
    (l_poly_contact, l_ndiff_contact): 170*nm, # (licon.2)
    (l_ndiffusion, l_pplus): 75*nm,
    (l_pdiffusion, l_nplus): 75*nm,
}

# Layer for the pins.
pin_layer = l_metal2 # lclayout.metal2 = sky130.metal1

# Power stripe layer
power_layer = [l_metal1, l_metal2] # lclayout.metal2 = sky130.metal1

# Layers that can be connected/merged without changing the schematic.
# This can be used to resolve spacing/notch violations by just filling the space.
connectable_layers = {l_nwell, l_pwell, l_poly}
# Width of the gate polysilicon stripe.
# is reused as the minimum_width for the l_poly layer
gate_length = 150*nm # (poly.1a)

# Minimum length a polysilicon gate must overlap the silicon.
gate_extension = 130*nm # (poly.8)

# Minimum distance of active area to upper or lower boundary of the cell. Basically determines the y-offset of the transistors.
transistor_offset_y = 240*nm # !!! This likely needs to be tuned later on # The 150/2*nm might have to be removed

# Standard cell dimensions.
# A 'unit cell' corresponds to the dimensions of the smallest possible cell. Usually an inverter.
# `unit_cell_width` also corresponds to the pitch of the gates because gates are spaced on a regular grid.
unit_cell_width = 1440*nm # 480*3 (unit SITE) # 1380*nm # 920 is 2*0.46um (unithd SITE),  8 * 130*nm
unit_cell_height = 3330*nm # (unit SITE) # 2720*nm #270*nm # 32 * 130*nm # minimum 16um due to pwell width + nwell-pwell spacing
#assert unit_cell_height >= 16*um, "minimum 16um due to pwell width + nwell-pwell spacing"
# due to nwell size and spacing requirements routing_grid_pitch_y * 8 # * 8

# Routing pitch
routing_grid_pitch_x = unit_cell_width // 6 # // 4
routing_grid_pitch_y = 135*nm # unit_cell_height // 8 // 2

# Translate routing grid such that the bottom left grid point is at (grid_offset_x, grid_offset_y)
grid_offset_x = routing_grid_pitch_x
grid_offset_y = 0 # (routing_grid_pitch_y // 2 ) -10

# Width of power rail.
power_rail_width = 480*nm # compatible to SKY130 #  3*130*nm # decided by the standard cell library architect

# Minimum width of polysilicon gate stripes.
# It increases w and l from the spice netlist, so it must be width from the spice netlist
minimum_gate_width_nfet = 150*nm # (poly.1a)
minimum_gate_width_pfet = 150*nm # (poly.1a)

# Minimum width for pins.
minimum_pin_width = 130*nm 

# Width of routing wires.
wire_width = {
    l_ndiffusion: 150*nm, # (difftap.1)
    l_pdiffusion: 150*nm, # (difftap.2)
    l_poly: 150*nm,   # (poly.1a)
    l_metal1: 170*nm, # (li.1)
    l_metal2: 140*nm, # (m1.1)
}

# Width of horizontal routing wires (overwrites `wire_width`).
wire_width_horizontal = {
    l_ndiffusion: 150*nm, # (difftap.1)
    l_pdiffusion: 150*nm, # (difftap.2)
    l_poly: 150*nm,   # (poly.1a)
    l_metal1: 170*nm, # (li.1)
    l_metal2: 140*nm, # (m1.1)
}

# Side lengths of vias (square shaped).
via_size = {
    l_poly_contact: 170*nm, # (ct.1)
    l_ndiff_contact: 170*nm, # (ct.1)
    l_pdiff_contact: 170*nm, # (ct.1)
    l_via1: 170*nm # (licon.1)
#    l_via2: 150*nm # (via.1a)
}

# Minimum width rules.
minimum_width = {
    l_ndiffusion: 150*nm, # (difftap.1)
    l_pdiffusion: 150*nm, # (difftap.1)
    l_poly: gate_length, 
    l_metal1: 170*nm, # (li.1)
    l_metal2: 140*nm, # (m1.1)
    l_nwell: 1000*nm
}

# Minimum enclosure rules.
# Syntax: {(outer layer, inner layer): minimum enclosure, ...}
minimum_enclosure = {
    # Via enclosure
    (l_ndiffusion, l_ndiff_contact): 60*nm, # (licon.5a)
    (l_pdiffusion, l_pdiff_contact): 60*nm, # (licon.5a)
    (l_poly, l_poly_contact): 80*nm, # (licon.8a) !!! OR (licon.4) ?
    (l_metal1, l_pdiff_contact): 80*nm, # (li.5)
    (l_metal1, l_ndiff_contact): 80*nm, # (li.5)
    (l_metal1, l_poly_contact): 80*nm, # (li.5)
    (l_metal1, l_via1): 0*nm, # this was 0,# (ct.4)
    (l_metal2, l_via1): 60*nm,# (m1.4)

    # l_*well must overlap l_*diffusion
#    (l_nwell, l_pdiffusion): 180*nm+130*nm, # (difftap.8) # This causes notches, I am trying to get rid of them
    (l_pwell, l_ndiffusion): 180*nm, # (difftap.8)
    (l_abutment_box, l_nwell): 0, # The nwell and pwell should not go beyond the abutment
    (l_abutment_box, l_pwell): 0,
    (l_nplus, l_ndiff_contact): 80*nm,  # Implicitly encodes the size of well taps.
    (l_pplus, l_pdiff_contact): 80*nm,  # Implicitly encodes the size of well taps.

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
    l_metal1: 0.0561 * um * um ,#  !!! TEMPORARILY DISABLED, PLEASE ENABLE AGAIN
    l_metal2: 0.083 * um * um ,# !!! TEMPORARILY DISABLED, PLEASE ENABLE AGAIN
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
#    (l_metal1, l_nplus): 1, # Contact to Well Taps, the value doesn't matter
#    (l_metal1, l_pplus): 1,

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

if( min_spacing[(l_via1, l_via1)] < min_spacing[(l_metal1,l_metal1)]+2*minimum_enclosure[(l_metal1, l_via1)]):
        newmin=min_spacing[(l_metal1,l_metal1)]+2*minimum_enclosure[(l_metal1, l_via1)]
        print("Minimum Spacing "+str(min_spacing[(l_via1, l_via1)])+" for via1 too small because of local interconnect, minimum should be "+ str(newmin)+"(="+str(min_spacing[(l_metal1,l_metal1)])+"+2*"+str(minimum_enclosure[(l_metal1, l_via1)])+") Fixing minimum_spacing")
        min_spacing[(l_via1, l_via1)]=newmin

if( min_spacing[(l_via1, l_via1)] < min_spacing[(l_metal2,l_metal2)]+2*minimum_enclosure[(l_metal2, l_via1)]):
        newmin=min_spacing[(l_metal2,l_metal2)]+2*minimum_enclosure[(l_metal2, l_via1)]
        print("Minimum Spacing "+str(min_spacing[(l_via1, l_via1)])+" for via1 too small because of metal1, minimum should be "+ str(newmin)+"(="+str(min_spacing[(l_metal2,l_metal2)])+"+2*"+str(minimum_enclosure[(l_metal2, l_via1)])+") Fixing minimum_spacing")
        min_spacing[(l_via1, l_via1)]=newmin



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

#print("grid_offset_y: "+str(grid_offset_y))
grid_ys = list(range(grid_offset_y, grid_offset_y + unit_cell_height +1, routing_grid_pitch_y))
print("grid_before: "+str(grid_ys))
grid_ys[2] += 110*nm
grid_ys[-3] -= 110*nm
grid_ys[14] -= 10*nm
grid_ys[1] = 0
grid_ys[-2] = unit_cell_height
grid_ys.pop(-1)
grid_ys.pop(0)
print("grid_after: "+str(grid_ys))



def powervias(unit_cell_width): 
    return list(range(240*nm,unit_cell_width,480*nm))

power_vias=powervias
