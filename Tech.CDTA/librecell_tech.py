from lclayout.layout.layers import *
from lclayout.writer.magic_writer import MagWriter
from lclayout.writer.lef_writer import LefWriter
from lclayout.writer.gds_writer import GdsWriter

# Physical size of one data base unit in meters.
# CDTA
# BUT GDS2 requires the database units to be in nanometers
db_unit = 1e-9

# Lambda - how many db_units is 1 lambda?
l = 500
um = 1000
nm = 1

# Scale transistor width.
transistor_channel_width_sizing = 1

# GDS2 layer numbers for final output.
my_nwell = (10, 0) # CWN
my_active = (20, 0) # CAA Diffusion and Channel area (ndiffusion+pdiffusion)
#my_ndiffusion = (1, 0)
#my_pdiffusion = (1, 7)
#my_nwell2 = (2, 1) # a copy of the nwell layer due to limitations of other tools we don't need
#my_pwell = (2, 7)
my_poly1 = (30, 0) # gate, interconnect and bottom plate of analog capacitor
my_poly2 = (35, 0) # interconnect, top plate of analog capacitor and poly resistor
my_nplus = (40, 0) # nmost source and drain
my_pplus = (45, 0) # pmost source and drain
my_contact = (50, 0) # CCC, CCG  (poly_contact + diff_contact)
#my_poly_contact = (4, 0) # Both poly_contact and diff_contact are the same in Libresilicon and they are both just one layer called "CONTACT"
#my_diff_contact = (5, 0) # Both poly_contact and diff_contact are the same in Libresilicon and they are both just one layer called "CONTACT"
my_metal1 = (60, 0)
my_metal1_label = (60, 1)
my_metal1_pin = (60, 2)
my_via1 = (55, 0) # CV1,CVA
my_metal2 = (65, 0)
my_metal2_label = (65, 1)
my_metal2_pin = (65, 2)
#my_glass = (90, 0) # COG
my_iframe = (200, 0) # abutment_box = (200, 0)

# lclayout internally uses its own layer numbering scheme.
# For the final output the layers can be remapped with a mapping
# defined in this dictioinary.
output_map = {
    l_ndiffusion: my_active,
    l_pdiffusion: my_active,
    l_nwell: my_nwell, # [my_nwell, my_nwell2],  # Map l_nwell to two output layers.
    l_pwell: [], #my_pwell Output layer for pwell. Uncomment this if needed. For instance for twin-well processes.
    l_poly: my_poly1,
    l_poly_contact: my_contact,
    l_diff_contact: my_contact,
    l_metal1: my_metal1,
    l_metal1_label: my_metal1_label,
    l_metal1_pin: my_metal1_pin,
    l_via1: my_via1,
    l_metal2: my_metal2,
    l_metal2_label: my_metal2_label,
    l_metal2_pin: my_metal2_pin,
    l_abutment_box: my_iframe
}

# Define a list of output writers.
output_writers = [
    MagWriter(
        tech_name='scmos',
        scale_factor=0.004, # Scale all coordinates by this factor (rounded down to next integer).
        output_map={
            l_via1: 'm2contact',
            l_poly: 'polysilicon',
            l_abutment_box: ['fence'],
            l_metal1: 'metal1',
            l_metal2: 'metal2',
            l_metal1_label: 'metal1',
            l_metal2_label: 'metal2',
            l_ndiffusion: 'ndiffusion', # -> active ???
            l_pdiffusion: 'pdiffusion',
            l_metal2_pin: 'metal2',
            l_poly_contact: 'polycontact',
            l_diff_contact: 'pdcontact'
        }
    ),

    LefWriter(
        db_unit=db_unit,
        output_map=output_map
    ),

    GdsWriter(
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
    l_metal1: 'hv',# hv?
    l_metal2: 'hv',# hv?
}

# Minimum spacing rules for layer pairs.
min_spacing = {
    (l_ndiffusion, l_ndiffusion): 2*um, # Rule 2.2
    (l_pdiffusion, l_ndiffusion): 2*um, # Rule 2.2
    (l_pdiffusion, l_pdiffusion): 2*um, # Rule 2.2
    (l_ndiffusion, l_poly_contact): 1000*nm, # Rule 7.4 ? Was there another rule that mandated 1.5 um?
    (l_pdiffusion, l_poly_contact): 1000*nm, # Rule 7.4 ?
    (l_nwell, l_nwell): 4*um, # Rule 1.3
    (l_nwell, l_pwell): 10*l, # 2.2.4->12l
    (l_pwell, l_pwell): 4*um, # 3 -> 10l
    (l_poly, l_nwell): 1*um, 
    (l_poly, l_ndiffusion): 1500*nm,
    (l_poly, l_pdiffusion): 1500*nm,
    (l_poly, l_poly): 1500*nm, # Rule 3.2
    (l_poly, l_diff_contact): 1*um, # Rule 8.4 ? Or 2um?
    (l_diff_contact, l_diff_contact): 1500*nm, # Rule 7.3 + Rule 8.3
    (l_metal1, l_metal1): 1500*nm, # Rule 9.2
    (l_metal2, l_metal2): 1500*nm, # Rule 11.2
    (l_via1, l_via1): 1500*nm, # Rule 10.2
    (l_via1, l_diff_contact): 1500*nm, # Rule 10.4 WARNING: STACKED VIAS ARE FORBIDDEN!!!
    (l_via1, l_ndiffusion): 1500*nm, # Rule 10.5
    (l_via1, l_pdiffusion): 1500*nm,
    (l_poly_contact, l_diff_contact): 1500*nm,
}

# Layer for the pins.
pin_layer = l_metal2

# Power stripe layer
power_layer = l_metal1 

# Layers that can be connected/merged without changing the schematic.
# This can be used to resolve spacing/notch violations by just filling the space.
connectable_layers = {l_nwell, l_pwell}
# Width of the gate polysilicon stripe.
# is reused as the minimum_width for the l_poly layer
gate_length = 1*um 

# Minimum length a polysilicon gate must overlap the silicon.
gate_extension = 1*um # Rule 3.3

# Minimum distance of active area to upper or lower boundary of the cell. Basically determines the y-offset of the transistors.
transistor_offset_y = 12*l

# Standard cell dimensions.
# A 'unit cell' corresponds to the dimensions of the smallest possible cell. Usually an inverter.
# `unit_cell_width` also corresponds to the pitch of the gates because gates are spaced on a regular grid.
unit_cell_width = 8*um
unit_cell_height = 32*um # minimum 16um due to pwell width + nwell-pwell spacing
assert unit_cell_height >= 16*um, "minimum 16um due to pwell width + nwell-pwell spacing"
# due to nwell size and spacing requirements routing_grid_pitch_y * 8 # * 8

# Routing pitch
routing_grid_pitch_x = unit_cell_width // 2 // 1
routing_grid_pitch_y = 1*um # unit_cell_height // 8 // 2

# Translate routing grid such that the bottom left grid point is at (grid_offset_x, grid_offset_y)
grid_offset_x = routing_grid_pitch_x
grid_offset_y = (routing_grid_pitch_y // 2 ) -0

# Width of power rail.
power_rail_width = 3*um  # Minimum according to DRC rules is 1.5um , feel free to reduce below 3.um if you are sure that it is a good idea.
# Between 2 and 3 um

# Minimum width of polysilicon gate stripes.
# It increases w and l from the spice netlist, so it must be width from the spice netlist
minimum_gate_width_nfet = 1*um
minimum_gate_width_pfet = 1*um

# Minimum width for pins.
minimum_pin_width = 1*um

# Width of routing wires.
wire_width = {
    l_ndiffusion: 1*um,
    l_pdiffusion: 1*um,
    l_poly: 1*um,   # Rule 3.1
    l_metal1: 1500*nm, # Rule 9.1
    l_metal2: 1500*nm, # Rule 11.1
}

# Width of horizontal routing wires (overwrites `wire_width`).
wire_width_horizontal = {
    l_ndiffusion: 1*um,
    l_pdiffusion: 1*um,
    l_poly: 1*um, #  Rule 3.1
    l_metal1: 1500*nm, # Rule 9.1
    l_metal2: 1500*nm, # 
}

# Side lengths of vias (square shaped).
via_size = {
    l_poly_contact: 1*um, # Rule 7.1
    l_diff_contact: 1*um, # Rule 8.1
    l_via1: 1*um # Rule 10.1
#    l_via2: 10 # librecell only goes to metal2, via2 would go to metal3
}

# Minimum width rules.
minimum_width = {
    l_ndiffusion: 1*um, # Rule 2.1
    l_pdiffusion: 1*um, # Rule 2.1
    l_poly: gate_length, # Rule 3.1
    l_metal1: 3*l, # Rule 9.1
    l_metal2: 3*l, # Rule 11.1
    l_nwell: 5*um, # Rule 1.1
}

# Minimum enclosure rules.
# Syntax: {(outer layer, inner layer): minimum enclosure, ...}
minimum_enclosure = {
    # Via enclosure
    (l_ndiffusion, l_diff_contact): 750*nm, # Rule 8.2 ? Thomas?
    (l_pdiffusion, l_diff_contact): 750*nm, # Rule 8.2 ?
    (l_poly, l_poly_contact): 750*nm, #Rule 7.2
    (l_metal1, l_diff_contact): 500*nm, #Rule 9.3
    (l_metal1, l_poly_contact): 500*nm, #Rule 9.3
    (l_metal1, l_via1): 500*nm, #Rule 10.3
    (l_metal2, l_via1): 500*nm, #Rule 11.3

    # l_*well must overlap l_*diffusion
    (l_nwell, l_pdiffusion): 3*um, # Rule 2.6.a
    (l_pwell, l_ndiffusion): 2*l, # 2.3.3 -> 2l
    (l_abutment_box, l_nwell): 0, # The nwell and pwell should not go beyond the abutment
    (l_abutment_box, l_pwell): 0,
}

# Minimum notch rules.
minimum_notch = {
    l_ndiffusion: 2*um, # Rule 2.2 ???
    l_pdiffusion: 2*um, # Rule 2.2 ???
    l_poly: 1*l, # ???
    l_metal1: 1*l,
    l_metal2: 1*l,
    l_nwell: 1*l,
    l_pwell: 1*l,
}

# Minimum area rules.
min_area = {
#    l_metal1: 100 * 100,
#    l_metal2: 100 * 100,
}

# ROUTING #

# Cost for changing routing direction (horizontal/vertical).
# This will avoid creating zig-zag routings.
orientation_change_penalty = 100

# Routing edge weights per data base unit.
weights_horizontal = {
    l_ndiffusion: 10000,
    l_pdiffusion: 10000,
    l_poly: 10,
    l_metal1: 1,
    l_metal2: 5,
}
weights_vertical = {
    l_ndiffusion: 10000,
    l_pdiffusion: 10000,
    l_poly: 10,
    l_metal1: 5,
    l_metal2: 1,
}

# Via weights.
via_weights = {
    (l_metal1, l_ndiffusion): 500,
    (l_metal1, l_pdiffusion): 500,
    (l_metal1, l_poly): 500,
    (l_metal1, l_metal2): 400
}

# Enable double vias between layers.
multi_via = {
    (l_metal1, l_poly): 1,
    (l_metal1, l_metal2): 1,
}

# Ask Thomas Kramer: 
# * Minimum Space between two active regions, one connected by metal
#   to VDD and the other connected by metal to VSS (not illustrated).
# Rule 3.4
# 3.5 ?
# 9.4+11.4 Big Metal rule please

# Ask both:
# Minimum separation from a COLD N-well to N+ active (see COLD N-
# well for more detail)
# Space from N-well to N+ active outside N-well (COLD WELL)
#
#Minimum separation from a HOT N-well to N+ active (see HOT N-well
#for more detail)
#Space from N-well to N+ active outside N-well (HOT WELL)

# Ask Djamel: 2.6 , 10.5a is missing in the graphics, explanation not clear

