-- Add items to existing profiles or create your own to sell groups of items using alias commands
local profiles = {}

profiles['junk'] = S{
	'Acheron Shield',
	'Acorn',
	'Adaman Ore',
	'Adamantoise Shell',
	'Adoulinian Kelp',
	'Ahriman Tears',
	'Aht Urhgan Brass',
	'Akaso',
	'Antican Acid',
	'Antican Pauldron',
	'Antlion Jaw',
	'Apkallu Feather',
    'Arnica Root',
	'Arrowwood Log',
	'Ash Log',
	'Auric Sand',
	'Barnacle',
	'Bastore Bream',
	'Bat Fang',
	'Bat Wing',
	'Bay Leaves',
	'Beast Blood',
	'Beehive Chip',
	'Beetle Jaw',
	'Bhefhel Marlin',
	'Bird Blood',
	'Bird Egg',
	'Bismuth Ore',
	'Black Eel',
	'Black Ghost',
	'Black Pepper',
	'Black Prawn',
	'Black Sole',
	'Blk. Tiger Fang',
	'Bloodblotch',
	'Blue Peas',
	'Bluetail',
	'Bomb Ash',
    'Bugard Skin',
	'Bugard Tusk',
	'Burdock',
	'Bone Chip',
	'Brass Loach',
	'Breeze Geode',
	'Ca Cuong',
	'Cactuar Needle',
	'Cactus Arm',
	'Cactus Stems', 
	'Carrier Crab Carapace',
	'Chapuli Horn',
	'Chapuli Wing',
	'Chestnut',
	'Chestnut Log',
	'Chestnut Sabots',
	'Chocobo Bedding',
    'Cluster Ash',
	'Cobalt Jellyfish',
	'Cockatrice Meat',
	'Cockatrice Skin',
	'Coeurl Meat',
	'Colibri Beak',
	'Cone Calamary',
	'Contortopus',
	'Copper Frog',
	'Copper Ore',
	'Coral Fungus',
	'Craklaw Pincer',
	'Crab Shell',
	'Crawler Cocoon',
	'Crawler Egg',
	'Crayfish',
	'Crescent Fish',
	'Danceshroom',
	'Dark Bass',
	'Dhalmel Hide',
	'Dst. Nugget',
	'Darksteel Ore',
	'Deathball',
	'Distilled Water',
	'Divine Log',
	'Dogwood Log',
	'Dragon Bone',
	'Dragon Fruit',
	'Dragon Talon',
	'Dragonfish',
	'Dryad Root',
	'Dwarf Remora',
	'Eastern Ginger',
	'Ebony Log',
	'Eggplant',
	'Elixir Vitae',
	'Elm Log',
	'Elshimo Newt',
	'El. Pachira Fruit',
	'Emperor Fish',
	'Ether',
	'Faerie Apple',
	'Felicifruit',
	'Fetich Arms',
	'Fetich Head',
	'Fetich Legs',
	'Fetich Torso',
	'Feyweald Log',
    'Fiend Blood',
	'Fish Bones',
	'Flax Flower',
	'Flint Stone',
	'Flytrap Leaf',
    'Four of Swords',
	'Fresh Marjoram',
	'Fresh Mugwort',
	'Frost Turnip',
	'Gavial Fish',
	'Giant Catfish',
	'Giant Femur',
	'Giant Stinger',
	'Gigant Squid',
	'Ginger',
	'Gold Carp',
	'Gold Ring',
	'Grain Seeds',
	'Green Rock',
	'Gregar. Worm',
	'Grimmonite',
	'Grove Cuttings',
	'Guatambu Log',
	'Gugru Tuna',
	'Habaneros',
	'Hare Meat',
	'Hecteyes Eye',
	'H.Q. Crab Shell',
	'H.Q. Scp. Shell',
    'Hi-Potion +2',
	'Honey',
	'Igneous Rock',
	'Imp Wing',
	'Infinity Core',
	'Insect Wing',
	'Iron Ore',
	'Isleracea',
	'Kapor Log',
	'Kazham Peppers',
	'Khroma Ore',
	'King Locust',
	'King Truffle',
	'Kopparnickel Ore',
	'Kukuru Bean',
	'La Theine Cbg.',
	'Lacquer Tree Log',
	'Lamp Marimo',
	'Land Crab Meat',
	'Lauan Log',
	'Leafkin Frond',
	'Lesser Chigoe',
	'Little Worm',
	'Lizard Blood',
	'Lizard Egg',
	'Lizard Tail',
	'Loc. Elutriator',
	'Mackerel',
	'Mahogany Log',
	'Maple Log',
	'Matamata Shell',
	'Marguerite',
	'Matsya',
	'Mercury',
	'Merrow Scale',
	'Meteorite',
	'Mhaura Garlic',
	'Millioncorn',
	'Moko Grass',
	'Moorish Idol',
	'Mushroom Locust',
	'Mythril Ore',
	'Napa',
	'Nopales',
	'Oak Log',
	'Orichalcum Ore',
	'Pamamas',
    'Pamtam Kelp',
	'Panopt Tears',
	'Pebble',
	'Peiste Skin',
	'Persikos',
	'Phrygian Ore',
	'Pine Nuts',
	'Pipira',
	'Poison Flour',
	'Popoto',
	'Potion',
	'Prize Powder',
	'Puffball',
	'Pugil Scales',
	'Pumpkin Pie',
	'Quadav Backplate',
	'Quus',
	'Raaz Hide',
	'Raaz Tusk',
	'Rabbit Hide',
	'Rafflesia Vine',
	'Ram Horn',
	'Raptor Skin',
	'Red Moko Grass',
	'Red Rose',
	'Red Terrapin',
	'Revival Root',
	'Rolanberry',
	'Ronfaure Chestnut',
	'Ruddy Seema',
	'Rusty Bucket',
	'Rye Flour',
    'Saffron Blossom',
	'Sage',
	'San d\'Or. Flour',
	'Saruta Cotton',
	'Scorpion Claw',
	'Scorpion Shell',
	'Seashell',
	'Semolina',
	'Senroh Sardine',
	'Shall Shell',
	'Shell Shield',
	'Sharug Greens',
	'Sheep Tooth',
	'Silver Ore',
	'Skull Locust',
	'Sleepshroom',
	'Slime Juice',
	'Snapping Mole',
	'Snap. Secretion',
	'Snap. Tendril',
	'Sobbing Fungus',
	'Spider Web',
	'Sunflower Seeds',
	'Swamp Ore',
	'Tarutaru Rice',
	'Thokcha Ingot',
	'Three-eyed Fish',
	'Tin Ore',
	'Tiny Goldfish',
	'Titanictus',
	'Titanium Ore',
	'Tree Cuttings',
	'Tricolored Carp',
	'Trumpet Ring',
	'Tulfaire Feather',
	'Turtle Shell',
	'Ulbuconut',
	'Uragnite Shell',
	'Urunday Log',
	'Vanadium Ore',
	'Velkk Mask',
	'Velkk Necklace',
	'Vanilla',
	'Walnut',
	'Walnut Log',
	'Watermelon',
	'White Sand',
	'Win. Tea Leaves',
	'Wijnruit',
	'Wild Pamamas',
	'Wivre Maul',
	'Woozyshroom',
	'Ulbukan Lobster',
	'Vegetable Seeds',
	'Vitriol',
	'Voay Staff -1',
	'Voay Sword -1',
	'Yagudo Cherry',
	'Yagudo Drink',
	'Yayinbaligi',
	'Yorchete',
	'Zebra Eel',
    'Zegham Carrot',
	'Zinc Ore',
}

return profiles
