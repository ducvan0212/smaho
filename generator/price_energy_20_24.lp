%electricity price /1000. cost(time,price)
cost(1..8, 202).
cost(9, 216).
cost(10..12,230).
cost(13..18, 253).
cost(19..21, 230).
cost(22, 216).
cost(23..24,202).

%maximal energyconsumption
max_energy(1000).

%-----------------devices----------------%
%define devices dev(id, type_location, consumed_enery_in_wh)
%light %each light consists of 2 lights, then 30Wh
dev(1, light_kitchen,30).
dev(2, light_living, 30).
dev(3, light_sleeping,30).
dev(4, light_yard, 30).

%hob
dev(5, hob_kitchen, 3000).

%TV %guess value for energy
dev(6, tv_kitchen, 100).
dev(7, tv_living, 100).
dev(8, tv_sleep, 100).

%cuttinggrass
dev(9, cg_yard, 1000).

%security %guess value for energy
dev(10, alarm1_outside, 15).
dev(11, alarm2_outside, 15).
dev(12, alarm3_outside, 15).

%washer
dev(13, washer_laundry, 1200).

%dryer
dev(14, dryer_laundry, 2500).

%electronic vehicle charger
dev(15, ev_yard, 3500).

%desktop
dev(16, desktop, 300).

%laptop
dev(17, laptop1, 100).
dev(18, laptop2, 100).
dev(19, laptop3, 100).

%diskwasher
dev(20, dw, 750).