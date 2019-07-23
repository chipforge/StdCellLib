from lclayout.layout.layers import *

# Physical size of one data base unit in meters.
# Libresilicon: 100nm was chosen, so 1 lambda is 5 units of 1e-7, so every lambda value has to be multiplied by 5
db_unit = 1e-7

# Scale transistor width.
transistor_channel_width_sizing = 1

# GDS2 layer numbers for final output.
my_active = (1, 0) # all DIFF's + all FET's
my_nwell = (2, 0)
#my_nwell2 = (2, 1) # a copy of the nwell layer due to limitations of other tools we don't need
my_pwell = (2, 7)
my_poly = (3, 0)
my_poly_contact = (4, 0) # Both poly_contact and diff_contact are the same in Libresilicon and they are both just one layer called "CONTACT"
my_diff_contact = (5, 0) # Both poly_contact and diff_contact are the same in Libresilicon and they are both just one layer called "CONTACT"
my_metal1 = (6, 0)
my_metal1_label = (6, 1)
my_metal1_pin = (6, 2)
my_via1 = (7, 0)
my_metal2 = (8, 0)
my_metal2_label = (8, 1)
my_metal2_pin = (8, 2)
my_abutment_box = (200, 0)

# lclayout internally uses its own layer numbering scheme.
# For the final output the layers can be remapped with a mapping
# defined in this dictioinary.
output_map = {
    l_active: my_active,
    l_nwell: my_nwell, # [my_nwell, my_nwell2],  # Map l_nwell to two output layers.
    l_pwell: my_pwell,  # Output layer for pwell. Uncomment this if needed. For instance for twin-well processes.
    l_poly: my_poly,
    l_poly_contact: my_poly_contact,
    l_diff_contact: my_diff_contact,
    l_metal1: my_metal1,
    l_metal1_label: my_metal1_label,
    l_metal1_pin: my_metal1_pin,
    l_via1: my_via1,
    l_metal2: my_metal2,
    l_metal2_label: my_metal2_label,
    l_metal2_pin: my_metal2_pin,
    l_abutment_box: my_abutment_box
}

# Define how layers can be used for routing.
# Example for a layer that can be used for horizontal and vertical tracks: {'MyLayer1' : 'hv'}
# Example for a layer that can be contacted but not used for routing: {'MyLayer2' : ''}
routing_layers = {
    l_active: '',
    l_poly: 'hv',
    l_metal1: 'hv',
    l_metal2: 'hv',
}

# Minimum spacing rules for layer pairs.
min_spacing = {
    (l_active, l_active): 15, # 3 -> 3l
    (l_active, l_poly_contact): 20, # 2.6.6 -> 4l
    (l_nwell, l_nwell): 50, # 3 -> 10l
    (l_nwell, l_pwell): 50, # 2.2.2->10l 
    (l_pwell, l_pwell): 50, # 3 -> 10l
    #(l_poly, l_nwell): 10, # No rule?
    (l_poly, l_active): 5, # 2.4.6 -> 1l
    (l_poly, l_poly): 10, # 3 POLY -> 2l
    (l_poly, l_diff_contact): 10, # The maximum "minimum spacing" from poly to anything else is 2l
    (l_metal1, l_metal1): 20, # 3 METAL1 -> 4l # !!!! WARNING: Spacing to BigMetal (>=10um) needs to be 6l !
    (l_metal2, l_metal2): 20, # 3 METAL2 -> 4l
    (l_via1, l_via1): 15, # 3 VIA1 -> 3l
    (l_via1, l_diff_contact): 10, # 2.8.3 -> 2l
    (l_via1, l_active): 10, # 2.8.4 -> 2l
}

# Layer for the pins.
pin_layer = l_metal2

# Power stripe layer
power_layer = l_metal1 # Was recommended by leviathanch due to lesser resistance

# Layers that can be connected/merged without changing the schematic.
# This can be used to resolve spacing/notch violations by just filling the space.
connectable_layers = {l_nwell, l_pwell}

# Standard cell dimensions.
# A 'unit cell' corresponds to the dimensions of the smallest possible cell. Usually an inverter.
# `unit_cell_width` also corresponds to the pitch of the gates because gates are spaced on a regular grid.
unit_cell_width = 80
unit_cell_height = 360

# Width of the gate polysilicon stripe.
gate_length = 10 # 2.4.1 -> 2l

# Minimum length a polysilicon gate must overlap the silicon.
gate_extension = 10 # 2.4.4 -> 2l

# Routing pitch
routing_grid_pitch_x = 20 # unit_cell_width // 8
routing_grid_pitch_y = 20 # unit_cell_height // 30

# Translate routing grid such that the bottom left grid point is at (grid_offset_x, grid_offset_y)
grid_offset_x = 10 # routing_grid_pitch_x
grid_offset_y = 0 # routing_grid_pitch_y // 2

# Width of power rail.
power_rail_width = 40
# Between 2 and 3 um

# Minimum width of polysilicon gate stripes.
minimum_gate_width_nfet = 10
minimum_gate_width_pfet = 10

# Minimum width for pins.
minimum_pin_width = 10

# Width of routing wires.
wire_width = {
#    l_nwell: 20,  # ?!? Why is there a wire with for nwell/pwell?!?
#    l_pwell: 20,
    l_poly: 10,   # 2.4.1 -> 2l
    l_metal1: 20, # 2.7.1 -> 4l
    l_metal2: 20, # 2.9.1 -> 4l
}

# Width of horizontal routing wires (overwrites `wire_width`).
wire_width_horizontal = {
    l_poly: 10, # 2.4.1 -> 2l
    l_metal1: 20, # 2.7.1 -> 4l
    l_metal2: 20, # 2.9.1 -> 4l
}

# Side lengths of vias (square shaped).
via_size = {
    l_poly_contact: 10, # 2.6.1 -> 2l
    l_diff_contact: 10, # 2.6.1 -> 2l
    l_via1: 10 # 2.8.1 -> 2l
#    l_via2: 10 # 2.10.1 -> 2l
}

# Minimum width rules.
minimum_width = {
    l_poly: gate_length, # 2.4.1-> 2l
    l_metal1: 20, # 2.7.1 -> 4l
    l_metal2: 20, # 2.9.1 -> 4l
}

# Minimum enclosure rules.
# Syntax: {(outer layer, inner layer): minimum enclosure, ...}
minimum_enclosure = {
    # Via enclosure
    (l_active, l_diff_contact): 30, # 2.3.3 -> 6l  Source/Drain are DIFF's
    (l_poly, l_poly_contact): 5, # 2.6.2 -> 1l ?!?!? PLEASE VERIFY WHETHER THIS IS CORRECT
    (l_metal1, l_diff_contact): 5, # 2.7.3 -> 1l
    (l_metal1, l_poly_contact): 5, # 2.7.3 -> 1l
    (l_metal1, l_via1): 5,# 2.7.3 -> 1l
    (l_metal2, l_via1): 5,# 2.9.3 -> 1l

    # l_nwell must overlap l_active
    (l_nwell, l_active): 15, # 2.3.4 -> 3l ?!?!? PLEASE VERIFY WHETHER THIS IS CORRECT
    (l_pwell, l_active): 15, # 2.3.4 -> 3l
}

# Minimum notch rules.
minimum_notch = {
    l_active: 5,
    l_poly: 5,
    l_metal1: 5,
    l_metal2: 5,
    l_nwell: 5
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
    l_poly: 10,
    l_metal1: 1,
    l_metal2: 2,
}
weights_vertical = {
    l_poly: 10,
    l_metal1: 1,
    l_metal2: 2,
}

# Via weights.
via_weights = {
    (l_metal1, l_active): 500,
    (l_metal1, l_poly): 500,
    (l_metal1, l_metal2): 400
}

# Enable double vias between layers.
multi_via = {
    (l_metal1, l_poly): 1,
    (l_metal1, l_metal2): 1,
}
