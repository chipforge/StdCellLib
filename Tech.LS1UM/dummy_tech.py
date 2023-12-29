from lclayout.layout.layers import *

# Physical size of one data base unit in meters.
db_unit = 1e-9

# Scale transistor width.
transistor_channel_width_sizing = 0.7

# GDS2 layer numbers for final output.
my_active = (1, 0)
my_nwell = (2, 0)
my_nwell2 = (2, 1)
my_pwell = (2, 7)
my_poly = (3, 0)
my_poly_contact = (4, 0)
my_diff_contact = (5, 0)
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
    l_nwell: [my_nwell, my_nwell2],  # Map l_nwell to two output layers.
    l_pwell: [my_pwell],  # Output layer for pwell. Uncomment this if needed. For instance for twin-well processes.
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
    (l_active, l_active): 50,
    (l_active, l_poly_contact): 10,
    (l_nwell, l_nwell): 50,
    (l_nwell, l_pwell): 0,  # This might be used when n-well and p-well layers are used for a twin-well process.
    (l_pwell, l_pwell): 50,
    (l_poly, l_nwell): 50,
    (l_poly, l_active): 50,
    (l_poly, l_poly): 50,
    (l_poly, l_diff_contact): 10,
    (l_metal1, l_metal1): 50,
    (l_metal2, l_metal2): 100,
}

# Layer for the pins.
pin_layer = l_metal2

# Power stripe layer
power_layer = l_metal1

# Layers that can be connected/merged without changing the schematic.
# This can be used to resolve spacing/notch violations by just filling the space.
connectable_layers = {l_nwell}

# Standard cell dimensions.
# A 'unit cell' corresponds to the dimensions of the smallest possible cell. Usually an inverter.
# `unit_cell_width` also corresponds to the pitch of the gates because gates are spaced on a regular grid.
unit_cell_width = 400
unit_cell_height = 2400

# Width of the gate polysilicon stripe.
gate_length = 50

# Minimum length a polysilicon gate must overlap the silicon.
gate_extension = 100

# Routing pitch
routing_grid_pitch_x = unit_cell_width // 2
routing_grid_pitch_y = unit_cell_height // 8

# Translate routing grid such that the bottom left grid point is at (grid_offset_x, grid_offset_y)
grid_offset_x = routing_grid_pitch_x
grid_offset_y = routing_grid_pitch_y // 2

# Width of power rail.
power_rail_width = 360

# Minimum width of polysilicon gate stripes.
minimum_gate_width_nfet = 200
minimum_gate_width_pfet = 200

# Minimum width for pins.
minimum_pin_width = 50

# Width of routing wires.
wire_width = {
    l_poly: 100,
    l_metal1: 100,
    l_metal2: 100
}

# Width of horizontal routing wires (overwrites `wire_width`).
wire_width_horizontal = {
    l_poly: 100,
    l_metal1: 100,
    l_metal2: 100
}

# Side lengths of vias (square shaped).
via_size = {
    l_poly_contact: 80,
    l_diff_contact: 80,
    l_via1: 100
}

# Minimum width rules.
minimum_width = {
    l_poly: gate_length,
    l_metal1: 100,
    l_metal2: 100
}

# Minimum enclosure rules.
# Syntax: {(outer layer, inner layer): minimum enclosure, ...}
minimum_enclosure = {
    # Via enclosure
    (l_active, l_diff_contact): 10,
    (l_poly, l_poly_contact): 10,
    (l_metal1, l_diff_contact): 10,
    (l_metal1, l_poly_contact): 10,
    (l_metal1, l_via1): 20,
    (l_metal2, l_via1): 20,

    # l_nwell must overlap l_active
    (l_nwell, l_active): 100
}

# Minimum notch rules.
minimum_notch = {
    l_active: 50,
    l_poly: 50,
    l_metal1: 50,
    l_metal2: 50,
    l_nwell: 50
}

# Minimum area rules.
min_area = {
    l_metal1: 100 * 100,
    l_metal2: 100 * 100,
}

# ROUTING #

# Cost for changing routing direction (horizontal/vertical).
# This will avoid creating zig-zag routings.
orientation_change_penalty = 100

# Routing edge weights per data base unit.
weights_horizontal = {
    l_poly: 2,
    l_metal1: 1,
    l_metal2: 1,
}
weights_vertical = {
    l_poly: 2,
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
