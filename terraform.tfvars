server_group={
    id          = "d27ee6b9-ef1a-4462-b8d1-0c08b5c5541e" 
  }

# os image  
image_source = {image_id="67ccb087-dcda-4067-98b1-cac7fa1ad0ea",volume_id=""}

#ID of the flavor the bastion will run on or name
flavor_id = "ea6b3d32-79a5-4d2e-a8e9-7ecf121ea7f4"
 
#Network port to assign to the node. Should be of type openstack_networking_port_v2
network_ports =  [{
    id          = "509fc214-3087-4ff5-955c-98534baa5863"
 
  }]

#Name of the external keypair that will be used to ssh to the bastion
keypair_name = "datacentric_k8s_key" 
 