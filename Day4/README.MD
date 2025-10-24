Assignment Question :

Please create a variable named "public_subnets" of type  map(object(...)) 
👾  Please refactor your code to use "for_each" rather than "count" 
👾  Please push again your work to github repo. And then let me know.


Revision:
- terraform refersh
- terraform refresh --false
- terraform apply --var-file prod.tfvars
- terraform stage list
- terraform stage show <resource>
- terraform show 
- terrafrom fmt 

Day4 Topic :
# variables ( date types -->)
# for_each versus count
# object
# Interpolation

# lists of objects 
# list , set -> default = []
# map -> default = {"key" = "value1", "key2" = "value2" ,"Key3" = "value3"}

# count // list
# for_each  // map data type loop  {}

each.key --> myanmar , english , chinese  ----Looping 
each.vlaue --> chit_tal , I_love_you, Wo_ai_Ni 

![alt text](image.png)