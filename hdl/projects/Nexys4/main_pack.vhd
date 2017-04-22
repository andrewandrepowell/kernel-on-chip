library ieee;
use ieee.std_logic_1164.all;

package main_pack is

	constant cpu_width : integer := 32;
	constant ram_size : integer := 536;
	subtype word_type is std_logic_vector(cpu_width-1 downto 0);
	type ram_type is array(0 to ram_size-1) of word_type;
	function load_hex return ram_type;

end package;

package body main_pack is

	function load_hex return ram_type is
		variable ram_buffer : ram_type := (others=>(others=>'0'));
	begin
		ram_buffer(0) := X"3C1C1001";
		ram_buffer(1) := X"279C8850";
		ram_buffer(2) := X"3C1D1000";
		ram_buffer(3) := X"27BD0888";
		ram_buffer(4) := X"0C00016E";
		ram_buffer(5) := X"00000000";
		ram_buffer(6) := X"23BDFF98";
		ram_buffer(7) := X"AFA10010";
		ram_buffer(8) := X"AFA20014";
		ram_buffer(9) := X"AFA30018";
		ram_buffer(10) := X"AFA4001C";
		ram_buffer(11) := X"AFA50020";
		ram_buffer(12) := X"AFA60024";
		ram_buffer(13) := X"AFA70028";
		ram_buffer(14) := X"AFA8002C";
		ram_buffer(15) := X"AFA90030";
		ram_buffer(16) := X"AFAA0034";
		ram_buffer(17) := X"AFAB0038";
		ram_buffer(18) := X"AFAC003C";
		ram_buffer(19) := X"AFAD0040";
		ram_buffer(20) := X"AFAE0044";
		ram_buffer(21) := X"AFAF0048";
		ram_buffer(22) := X"AFB8004C";
		ram_buffer(23) := X"AFB90050";
		ram_buffer(24) := X"AFBF0054";
		ram_buffer(25) := X"401A7000";
		ram_buffer(26) := X"235AFFFC";
		ram_buffer(27) := X"AFBA0058";
		ram_buffer(28) := X"0000D810";
		ram_buffer(29) := X"AFBB005C";
		ram_buffer(30) := X"0000D812";
		ram_buffer(31) := X"AFBB0060";
		ram_buffer(32) := X"0C000146";
		ram_buffer(33) := X"23A50000";
		ram_buffer(34) := X"8FA10010";
		ram_buffer(35) := X"8FA20014";
		ram_buffer(36) := X"8FA30018";
		ram_buffer(37) := X"8FA4001C";
		ram_buffer(38) := X"8FA50020";
		ram_buffer(39) := X"8FA60024";
		ram_buffer(40) := X"8FA70028";
		ram_buffer(41) := X"8FA8002C";
		ram_buffer(42) := X"8FA90030";
		ram_buffer(43) := X"8FAA0034";
		ram_buffer(44) := X"8FAB0038";
		ram_buffer(45) := X"8FAC003C";
		ram_buffer(46) := X"8FAD0040";
		ram_buffer(47) := X"8FAE0044";
		ram_buffer(48) := X"8FAF0048";
		ram_buffer(49) := X"8FB8004C";
		ram_buffer(50) := X"8FB90050";
		ram_buffer(51) := X"8FBF0054";
		ram_buffer(52) := X"8FBA0058";
		ram_buffer(53) := X"8FBB005C";
		ram_buffer(54) := X"03600011";
		ram_buffer(55) := X"8FBB0060";
		ram_buffer(56) := X"03600013";
		ram_buffer(57) := X"23BD0068";
		ram_buffer(58) := X"341B0001";
		ram_buffer(59) := X"03400008";
		ram_buffer(60) := X"409B6000";
		ram_buffer(61) := X"40026000";
		ram_buffer(62) := X"03E00008";
		ram_buffer(63) := X"40846000";
		ram_buffer(64) := X"3C051000";
		ram_buffer(65) := X"24A5012C";
		ram_buffer(66) := X"8CA60000";
		ram_buffer(67) := X"AC06003C";
		ram_buffer(68) := X"8CA60004";
		ram_buffer(69) := X"AC060040";
		ram_buffer(70) := X"8CA60008";
		ram_buffer(71) := X"AC060044";
		ram_buffer(72) := X"8CA6000C";
		ram_buffer(73) := X"03E00008";
		ram_buffer(74) := X"AC060048";
		ram_buffer(75) := X"3C1A1000";
		ram_buffer(76) := X"375A0018";
		ram_buffer(77) := X"03400008";
		ram_buffer(78) := X"00000000";
		ram_buffer(79) := X"00850019";
		ram_buffer(80) := X"00001012";
		ram_buffer(81) := X"00002010";
		ram_buffer(82) := X"03E00008";
		ram_buffer(83) := X"ACC40000";
		ram_buffer(84) := X"0000000C";
		ram_buffer(85) := X"03E00008";
		ram_buffer(86) := X"00000000";
		ram_buffer(87) := X"AC900000";
		ram_buffer(88) := X"AC910004";
		ram_buffer(89) := X"AC920008";
		ram_buffer(90) := X"AC93000C";
		ram_buffer(91) := X"AC940010";
		ram_buffer(92) := X"AC950014";
		ram_buffer(93) := X"AC960018";
		ram_buffer(94) := X"AC97001C";
		ram_buffer(95) := X"AC9E0020";
		ram_buffer(96) := X"AC9C0024";
		ram_buffer(97) := X"AC9D0028";
		ram_buffer(98) := X"AC9F002C";
		ram_buffer(99) := X"03E00008";
		ram_buffer(100) := X"34020000";
		ram_buffer(101) := X"8C900000";
		ram_buffer(102) := X"8C910004";
		ram_buffer(103) := X"8C920008";
		ram_buffer(104) := X"8C93000C";
		ram_buffer(105) := X"8C940010";
		ram_buffer(106) := X"8C950014";
		ram_buffer(107) := X"8C960018";
		ram_buffer(108) := X"8C97001C";
		ram_buffer(109) := X"8C9E0020";
		ram_buffer(110) := X"8C9C0024";
		ram_buffer(111) := X"8C9D0028";
		ram_buffer(112) := X"8C9F002C";
		ram_buffer(113) := X"03E00008";
		ram_buffer(114) := X"34A20000";
		ram_buffer(115) := X"3C022000";
		ram_buffer(116) := X"27BDFFD8";
		ram_buffer(117) := X"AF828014";
		ram_buffer(118) := X"3C022003";
		ram_buffer(119) := X"AF828010";
		ram_buffer(120) := X"AFB00014";
		ram_buffer(121) := X"3C022001";
		ram_buffer(122) := X"3C101000";
		ram_buffer(123) := X"AE0208AC";
		ram_buffer(124) := X"3C031000";
		ram_buffer(125) := X"3C021000";
		ram_buffer(126) := X"AFBF0024";
		ram_buffer(127) := X"AFB30020";
		ram_buffer(128) := X"AFB2001C";
		ram_buffer(129) := X"AFB10018";
		ram_buffer(130) := X"244208B0";
		ram_buffer(131) := X"246308F0";
		ram_buffer(132) := X"24420008";
		ram_buffer(133) := X"1443FFFE";
		ram_buffer(134) := X"AC40FFF8";
		ram_buffer(135) := X"3C021000";
		ram_buffer(136) := X"261208AC";
		ram_buffer(137) := X"244203B0";
		ram_buffer(138) := X"AE42000C";
		ram_buffer(139) := X"AE400010";
		ram_buffer(140) := X"3C13F000";
		ram_buffer(141) := X"8E630004";
		ram_buffer(142) := X"3C111000";
		ram_buffer(143) := X"00031100";
		ram_buffer(144) := X"00431021";
		ram_buffer(145) := X"00021080";
		ram_buffer(146) := X"26310794";
		ram_buffer(147) := X"24420004";
		ram_buffer(148) := X"3C031000";
		ram_buffer(149) := X"02221021";
		ram_buffer(150) := X"2463033C";
		ram_buffer(151) := X"AC430008";
		ram_buffer(152) := X"AC40000C";
		ram_buffer(153) := X"27858014";
		ram_buffer(154) := X"24060004";
		ram_buffer(155) := X"0C0001C8";
		ram_buffer(156) := X"24040004";
		ram_buffer(157) := X"27858010";
		ram_buffer(158) := X"24060004";
		ram_buffer(159) := X"0C0001C8";
		ram_buffer(160) := X"24040004";
		ram_buffer(161) := X"24060044";
		ram_buffer(162) := X"02402825";
		ram_buffer(163) := X"0C0001C8";
		ram_buffer(164) := X"24040004";
		ram_buffer(165) := X"8F838010";
		ram_buffer(166) := X"24020001";
		ram_buffer(167) := X"AC620008";
		ram_buffer(168) := X"8F838010";
		ram_buffer(169) := X"00000000";
		ram_buffer(170) := X"AC620000";
		ram_buffer(171) := X"8E0208AC";
		ram_buffer(172) := X"24030002";
		ram_buffer(173) := X"AC430000";
		ram_buffer(174) := X"8E630004";
		ram_buffer(175) := X"00000000";
		ram_buffer(176) := X"00031100";
		ram_buffer(177) := X"00431021";
		ram_buffer(178) := X"00021080";
		ram_buffer(179) := X"00511021";
		ram_buffer(180) := X"8C420000";
		ram_buffer(181) := X"24030003";
		ram_buffer(182) := X"3C101000";
		ram_buffer(183) := X"3C111000";
		ram_buffer(184) := X"3C051000";
		ram_buffer(185) := X"AC430000";
		ram_buffer(186) := X"261008F0";
		ram_buffer(187) := X"263103E4";
		ram_buffer(188) := X"24060004";
		ram_buffer(189) := X"24A508F4";
		ram_buffer(190) := X"24040004";
		ram_buffer(191) := X"0C0001C8";
		ram_buffer(192) := X"AE110004";
		ram_buffer(193) := X"3C051000";
		ram_buffer(194) := X"24060004";
		ram_buffer(195) := X"24A508F8";
		ram_buffer(196) := X"24040004";
		ram_buffer(197) := X"0C0001C8";
		ram_buffer(198) := X"AE110008";
		ram_buffer(199) := X"8FBF0024";
		ram_buffer(200) := X"8FB30020";
		ram_buffer(201) := X"8FB2001C";
		ram_buffer(202) := X"8FB10018";
		ram_buffer(203) := X"8FB00014";
		ram_buffer(204) := X"00001025";
		ram_buffer(205) := X"03E00008";
		ram_buffer(206) := X"27BD0028";
		ram_buffer(207) := X"27BDFFE0";
		ram_buffer(208) := X"AFBF001C";
		ram_buffer(209) := X"AFB10018";
		ram_buffer(210) := X"AFB00014";
		ram_buffer(211) := X"3C031000";
		ram_buffer(212) := X"8C6208AC";
		ram_buffer(213) := X"3C111000";
		ram_buffer(214) := X"8C420004";
		ram_buffer(215) := X"00608025";
		ram_buffer(216) := X"263108B0";
		ram_buffer(217) := X"2C430008";
		ram_buffer(218) := X"14600006";
		ram_buffer(219) := X"00000000";
		ram_buffer(220) := X"8FBF001C";
		ram_buffer(221) := X"8FB10018";
		ram_buffer(222) := X"8FB00014";
		ram_buffer(223) := X"03E00008";
		ram_buffer(224) := X"27BD0020";
		ram_buffer(225) := X"000210C0";
		ram_buffer(226) := X"02221021";
		ram_buffer(227) := X"8C430000";
		ram_buffer(228) := X"8C440004";
		ram_buffer(229) := X"0060F809";
		ram_buffer(230) := X"00000000";
		ram_buffer(231) := X"8E0208AC";
		ram_buffer(232) := X"00000000";
		ram_buffer(233) := X"8C420004";
		ram_buffer(234) := X"1000FFEF";
		ram_buffer(235) := X"2C430008";
		ram_buffer(236) := X"8F828010";
		ram_buffer(237) := X"24030003";
		ram_buffer(238) := X"AC430000";
		ram_buffer(239) := X"3C02F000";
		ram_buffer(240) := X"8C420004";
		ram_buffer(241) := X"3C031000";
		ram_buffer(242) := X"24630788";
		ram_buffer(243) := X"00021080";
		ram_buffer(244) := X"00431021";
		ram_buffer(245) := X"8C420000";
		ram_buffer(246) := X"24030001";
		ram_buffer(247) := X"03E00008";
		ram_buffer(248) := X"AC430000";
		ram_buffer(249) := X"27BDFFE8";
		ram_buffer(250) := X"27858014";
		ram_buffer(251) := X"24060004";
		ram_buffer(252) := X"AFBF0014";
		ram_buffer(253) := X"0C0001C8";
		ram_buffer(254) := X"00002025";
		ram_buffer(255) := X"27858010";
		ram_buffer(256) := X"24060004";
		ram_buffer(257) := X"0C0001C8";
		ram_buffer(258) := X"00002025";
		ram_buffer(259) := X"3C051000";
		ram_buffer(260) := X"24060044";
		ram_buffer(261) := X"24A508AC";
		ram_buffer(262) := X"0C0001C8";
		ram_buffer(263) := X"00002025";
		ram_buffer(264) := X"3C02F000";
		ram_buffer(265) := X"8C430004";
		ram_buffer(266) := X"24020001";
		ram_buffer(267) := X"14620008";
		ram_buffer(268) := X"00000000";
		ram_buffer(269) := X"8F828010";
		ram_buffer(270) := X"24060004";
		ram_buffer(271) := X"8C420004";
		ram_buffer(272) := X"27858018";
		ram_buffer(273) := X"24040004";
		ram_buffer(274) := X"0C0001C8";
		ram_buffer(275) := X"AF828018";
		ram_buffer(276) := X"3C02F000";
		ram_buffer(277) := X"8C430004";
		ram_buffer(278) := X"24020002";
		ram_buffer(279) := X"1462000A";
		ram_buffer(280) := X"24060004";
		ram_buffer(281) := X"27858018";
		ram_buffer(282) := X"0C0001C8";
		ram_buffer(283) := X"00002025";
		ram_buffer(284) := X"8F838018";
		ram_buffer(285) := X"8F828010";
		ram_buffer(286) := X"00000000";
		ram_buffer(287) := X"AC430008";
		ram_buffer(288) := X"1000FFF8";
		ram_buffer(289) := X"24060004";
		ram_buffer(290) := X"8FBF0014";
		ram_buffer(291) := X"00000000";
		ram_buffer(292) := X"03E00008";
		ram_buffer(293) := X"27BD0018";
		ram_buffer(294) := X"3C04F000";
		ram_buffer(295) := X"8C820004";
		ram_buffer(296) := X"3C031000";
		ram_buffer(297) := X"24630788";
		ram_buffer(298) := X"00021080";
		ram_buffer(299) := X"00431021";
		ram_buffer(300) := X"8C420000";
		ram_buffer(301) := X"24030002";
		ram_buffer(302) := X"AC430000";
		ram_buffer(303) := X"8C830004";
		ram_buffer(304) := X"24020001";
		ram_buffer(305) := X"14620008";
		ram_buffer(306) := X"00000000";
		ram_buffer(307) := X"8F828010";
		ram_buffer(308) := X"24060004";
		ram_buffer(309) := X"8C420004";
		ram_buffer(310) := X"27858018";
		ram_buffer(311) := X"24040004";
		ram_buffer(312) := X"080001C8";
		ram_buffer(313) := X"AF828018";
		ram_buffer(314) := X"03E00008";
		ram_buffer(315) := X"00000000";
		ram_buffer(316) := X"3C02F000";
		ram_buffer(317) := X"8C420004";
		ram_buffer(318) := X"3C031000";
		ram_buffer(319) := X"24630788";
		ram_buffer(320) := X"00021080";
		ram_buffer(321) := X"00431021";
		ram_buffer(322) := X"8C420000";
		ram_buffer(323) := X"24030002";
		ram_buffer(324) := X"03E00008";
		ram_buffer(325) := X"AC430000";
		ram_buffer(326) := X"27BDFFE0";
		ram_buffer(327) := X"AFBF001C";
		ram_buffer(328) := X"AFB20018";
		ram_buffer(329) := X"AFB10014";
		ram_buffer(330) := X"AFB00010";
		ram_buffer(331) := X"3C02F000";
		ram_buffer(332) := X"8C430004";
		ram_buffer(333) := X"00000000";
		ram_buffer(334) := X"00031100";
		ram_buffer(335) := X"00431021";
		ram_buffer(336) := X"00021080";
		ram_buffer(337) := X"24520004";
		ram_buffer(338) := X"3C111000";
		ram_buffer(339) := X"26310794";
		ram_buffer(340) := X"02221021";
		ram_buffer(341) := X"8C430000";
		ram_buffer(342) := X"00408025";
		ram_buffer(343) := X"8C630004";
		ram_buffer(344) := X"00000000";
		ram_buffer(345) := X"2C620008";
		ram_buffer(346) := X"14400007";
		ram_buffer(347) := X"00000000";
		ram_buffer(348) := X"8FBF001C";
		ram_buffer(349) := X"8FB20018";
		ram_buffer(350) := X"8FB10014";
		ram_buffer(351) := X"8FB00010";
		ram_buffer(352) := X"03E00008";
		ram_buffer(353) := X"27BD0020";
		ram_buffer(354) := X"000318C0";
		ram_buffer(355) := X"00721821";
		ram_buffer(356) := X"02231821";
		ram_buffer(357) := X"8C620000";
		ram_buffer(358) := X"8C640004";
		ram_buffer(359) := X"0040F809";
		ram_buffer(360) := X"00000000";
		ram_buffer(361) := X"8E020000";
		ram_buffer(362) := X"00000000";
		ram_buffer(363) := X"8C430004";
		ram_buffer(364) := X"1000FFED";
		ram_buffer(365) := X"2C620008";
		ram_buffer(366) := X"27BDFFE0";
		ram_buffer(367) := X"AFBF001C";
		ram_buffer(368) := X"AFB20018";
		ram_buffer(369) := X"AFB10014";
		ram_buffer(370) := X"AFB00010";
		ram_buffer(371) := X"3C05F000";
		ram_buffer(372) := X"8CA20004";
		ram_buffer(373) := X"00000000";
		ram_buffer(374) := X"00021280";
		ram_buffer(375) := X"244303E8";
		ram_buffer(376) := X"3C021000";
		ram_buffer(377) := X"244208FC";
		ram_buffer(378) := X"00431021";
		ram_buffer(379) := X"0040E825";
		ram_buffer(380) := X"8CB00004";
		ram_buffer(381) := X"8CA70004";
		ram_buffer(382) := X"00000000";
		ram_buffer(383) := X"00072100";
		ram_buffer(384) := X"8CA20004";
		ram_buffer(385) := X"3C031000";
		ram_buffer(386) := X"24630788";
		ram_buffer(387) := X"00021080";
		ram_buffer(388) := X"00431021";
		ram_buffer(389) := X"3C03F002";
		ram_buffer(390) := X"AC430000";
		ram_buffer(391) := X"00871021";
		ram_buffer(392) := X"3C031000";
		ram_buffer(393) := X"00021080";
		ram_buffer(394) := X"24630794";
		ram_buffer(395) := X"00432821";
		ram_buffer(396) := X"24420004";
		ram_buffer(397) := X"3C06F001";
		ram_buffer(398) := X"00621021";
		ram_buffer(399) := X"ACA60000";
		ram_buffer(400) := X"24A60044";
		ram_buffer(401) := X"00402825";
		ram_buffer(402) := X"14C5001F";
		ram_buffer(403) := X"24A50008";
		ram_buffer(404) := X"3C051000";
		ram_buffer(405) := X"24A50498";
		ram_buffer(406) := X"AC450000";
		ram_buffer(407) := X"AC400004";
		ram_buffer(408) := X"00872021";
		ram_buffer(409) := X"00042080";
		ram_buffer(410) := X"00641821";
		ram_buffer(411) := X"8C620000";
		ram_buffer(412) := X"24030001";
		ram_buffer(413) := X"0C000040";
		ram_buffer(414) := X"AC430000";
		ram_buffer(415) := X"0C00003D";
		ram_buffer(416) := X"24040001";
		ram_buffer(417) := X"16000014";
		ram_buffer(418) := X"3C111000";
		ram_buffer(419) := X"27868010";
		ram_buffer(420) := X"27828CAC";
		ram_buffer(421) := X"14C2000E";
		ram_buffer(422) := X"24C60004";
		ram_buffer(423) := X"24C6FFFC";
		ram_buffer(424) := X"27828010";
		ram_buffer(425) := X"24C60004";
		ram_buffer(426) := X"00C23023";
		ram_buffer(427) := X"00402825";
		ram_buffer(428) := X"0C0001C8";
		ram_buffer(429) := X"24040004";
		ram_buffer(430) := X"0C000073";
		ram_buffer(431) := X"00000000";
		ram_buffer(432) := X"1000FFFF";
		ram_buffer(433) := X"00000000";
		ram_buffer(434) := X"1000FFDF";
		ram_buffer(435) := X"ACA0FFF8";
		ram_buffer(436) := X"1000FFF0";
		ram_buffer(437) := X"ACC0FFFC";
		ram_buffer(438) := X"263108F0";
		ram_buffer(439) := X"00108080";
		ram_buffer(440) := X"3C12F000";
		ram_buffer(441) := X"02118021";
		ram_buffer(442) := X"8E450004";
		ram_buffer(443) := X"24060004";
		ram_buffer(444) := X"00052880";
		ram_buffer(445) := X"02252821";
		ram_buffer(446) := X"0C0001C8";
		ram_buffer(447) := X"00002025";
		ram_buffer(448) := X"8E020000";
		ram_buffer(449) := X"00000000";
		ram_buffer(450) := X"1040FFF7";
		ram_buffer(451) := X"00000000";
		ram_buffer(452) := X"0040F809";
		ram_buffer(453) := X"00000000";
		ram_buffer(454) := X"1000FFE9";
		ram_buffer(455) := X"00000000";
		ram_buffer(456) := X"10C0000C";
		ram_buffer(457) := X"00C53021";
		ram_buffer(458) := X"2402FFF0";
		ram_buffer(459) := X"00C21824";
		ram_buffer(460) := X"0066302B";
		ram_buffer(461) := X"00A22824";
		ram_buffer(462) := X"00063100";
		ram_buffer(463) := X"24620010";
		ram_buffer(464) := X"00463021";
		ram_buffer(465) := X"2484FF00";
		ram_buffer(466) := X"2402FFF0";
		ram_buffer(467) := X"14C50003";
		ram_buffer(468) := X"00A21824";
		ram_buffer(469) := X"03E00008";
		ram_buffer(470) := X"00000000";
		ram_buffer(471) := X"AC830000";
		ram_buffer(472) := X"AC600000";
		ram_buffer(473) := X"1000FFF9";
		ram_buffer(474) := X"24A50010";
		ram_buffer(475) := X"00000000";
		ram_buffer(476) := X"00000100";
		ram_buffer(477) := X"01010001";
		ram_buffer(478) := X"00000000";
		ram_buffer(479) := X"00000000";
		ram_buffer(480) := X"00000000";
		ram_buffer(481) := X"00000000";
		ram_buffer(482) := X"FFFFFFFF";
		ram_buffer(483) := X"FFFFFFFF";
		ram_buffer(484) := X"FFFFFFFF";
		ram_buffer(485) := X"FFFFFFFF";
		ram_buffer(486) := X"00000000";
		ram_buffer(487) := X"00000000";
		ram_buffer(488) := X"00000000";
		ram_buffer(489) := X"00000000";
		ram_buffer(490) := X"00000000";
		ram_buffer(491) := X"00000000";
		ram_buffer(492) := X"00000000";
		ram_buffer(493) := X"00000000";
		ram_buffer(494) := X"00000000";
		ram_buffer(495) := X"00000000";
		ram_buffer(496) := X"00000000";
		ram_buffer(497) := X"00000000";
		ram_buffer(498) := X"00000000";
		ram_buffer(499) := X"00000000";
		ram_buffer(500) := X"00000000";
		ram_buffer(501) := X"00000000";
		ram_buffer(502) := X"FFFFFFFF";
		ram_buffer(503) := X"00000000";
		ram_buffer(504) := X"00000000";
		ram_buffer(505) := X"00000000";
		ram_buffer(506) := X"00000000";
		ram_buffer(507) := X"00000000";
		ram_buffer(508) := X"00000000";
		ram_buffer(509) := X"00000000";
		ram_buffer(510) := X"00000000";
		ram_buffer(511) := X"00000000";
		ram_buffer(512) := X"00000000";
		ram_buffer(513) := X"00000000";
		ram_buffer(514) := X"00000000";
		ram_buffer(515) := X"00000000";
		ram_buffer(516) := X"00000000";
		ram_buffer(517) := X"00000000";
		ram_buffer(518) := X"00000000";
		ram_buffer(519) := X"FFFFFFFF";
		ram_buffer(520) := X"00000000";
		ram_buffer(521) := X"00000000";
		ram_buffer(522) := X"00000000";
		ram_buffer(523) := X"00000000";
		ram_buffer(524) := X"00000000";
		ram_buffer(525) := X"00000000";
		ram_buffer(526) := X"00000000";
		ram_buffer(527) := X"00000000";
		ram_buffer(528) := X"00000000";
		ram_buffer(529) := X"00000000";
		ram_buffer(530) := X"00000000";
		ram_buffer(531) := X"00000000";
		ram_buffer(532) := X"00000000";
		ram_buffer(533) := X"00000000";
		ram_buffer(534) := X"00000000";
		ram_buffer(535) := X"00000000";
		return ram_buffer;
	end;
end;
