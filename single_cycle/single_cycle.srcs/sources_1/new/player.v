`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 12:39:17 AM
// Design Name: 
// Module Name: player
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
module player(
	input				clk		,		//时钟输入
	input				rst_n	,		//复位按键输入
	input			[7:0] song	,		// 歌曲种类
	
	output	reg			buzzer			//驱动蜂鸣???
	);
	

	
	//定义音符时序周期???
	localparam			
						M0  = 98800,
						M1  = 191200,
						M2  = 170300,
						M3  = 151700,
						M4  = 143200,
						M5  = 127500,
						M6  = 113600,
						M7  = 101200,
						L1  = 381600,
						L2  = 340100,
						L3  = 303000,
						L4  = 286500,
						L5  = 255100,
						L6  = 227200,
						L7  = 202400,
						H1  = 95500,
						H2  = 85100,
						H3  = 75800,
						H4  = 75100,
						H5  = 63700,
						H6  = 56800,
						H7  = 50800;
	
	//信号定义
	reg		[31:0]		cnt0		;	//计数每个音符对应的时序周???
	reg		[31:0]		cnt1		;	//计数每个音符重复次数
	reg		[31 :0]		cnt2		;	//计数曲谱中音符个???
	
	reg		[31:0]		pre_set		;	//预装载???
	wire	[31:0]		pre_div		;	//占空???
	
	reg		[31:0]		cishu		;	//定义不同音符重复不同次数
	wire	[31:0]		cishu_div	;	//音符重复次数占空???
	
	reg 	[7:0]		flag		;	//歌曲种类标志???0小星星，1两只老虎
	reg		[31 :0]		YINFU		;	//定义曲谱中音符个???

	reg		[31:0] 		note_type; // 音符种类

	// 定义每个音符对应的常数
	localparam  L1_E8 = 0,
				L1_E4 = 1,
				L1_E2 = 2,
				L1_E3_2 = 3,
				L1_E1 = 4,
				L1_E1_2 = 5,
				L1_E1_4 = 6,
				L1_E1_8 = 7,
				L1_E1_16 = 8,
				L2_E8 = 9,
				L2_E4 = 10,
				L2_E2 = 11,
				L2_E3_2 = 12,
				L2_E1 = 13,
				L2_E1_2 = 14,
				L2_E1_4 = 15,
				L2_E1_8 = 16,
				L2_E1_16 = 17,
				L3_E8 = 18,
				L3_E4 = 19,
				L3_E2 = 20,
				L3_E3_2 = 21,
				L3_E1 = 22,
				L3_E1_2 = 23,
				L3_E1_4 = 24,
				L3_E1_8 = 25,
				L3_E1_16 = 26,
				L4_E8 = 27,
				L4_E4 = 28,
				L4_E2 = 29,
				L4_E3_2 = 30,
				L4_E1 = 31,
				L4_E1_2 = 32,
				L4_E1_4 = 33,
				L4_E1_8 = 34,
				L4_E1_16 = 35,
				L5_E8 = 36,
				L5_E4 = 37,
				L5_E2 = 38,
				L5_E3_2 = 39,
				L5_E1 = 40,
				L5_E1_2 = 41,
				L5_E1_4 = 42,
				L5_E1_8 = 43,
				L5_E1_16 = 44,
				L6_E8 = 45,
				L6_E4 = 46,
				L6_E2 = 47,
				L6_E3_2 = 48,
				L6_E1 = 49,
				L6_E1_2 = 50,
				L6_E1_4 = 51,
				L6_E1_8 = 52,
				L6_E1_16 = 53,
				L7_E8 = 54,
				L7_E4 = 55,
				L7_E2 = 56,
				L7_E3_2 = 57,
				L7_E1 = 58,
				L7_E1_2 = 59,
				L7_E1_4 = 60,
				L7_E1_8 = 61,
				L7_E1_16 = 62,
				M0_E8 = 63,
				M0_E4 = 64,
				M0_E2 = 65,
				M0_E3_2 = 66,
				M0_E1 = 67,
				M0_E1_2 = 68,
				M0_E1_4 = 69,
				M0_E1_8 = 70,
				M0_E1_16 = 71,
				M1_E8 = 72,
				M1_E4 = 73,
				M1_E2 = 74,
				M1_E3_2 = 75,
				M1_E1 = 76,
				M1_E1_2 = 77,
				M1_E1_4 = 78,
				M1_E1_8 = 79,
				M1_E1_16 = 80,
				M2_E8 = 81,
				M2_E4 = 82,
				M2_E2 = 83,
				M2_E3_2 = 84,
				M2_E1 = 85,
				M2_E1_2 = 86,
				M2_E1_4 = 87,
				M2_E1_8 = 88,
				M2_E1_16 = 89,
				M3_E8 = 90,
				M3_E4 = 91,
				M3_E2 = 92,
				M3_E3_2 = 93,
				M3_E1 = 94,
				M3_E1_2 = 95,
				M3_E1_4 = 96,
				M3_E1_8 = 97,
				M3_E1_16 = 98,
				M4_E8 = 99,
				M4_E4 = 100,
				M4_E2 = 101,
				M4_E3_2 = 102,
				M4_E1 = 103,
				M4_E1_2 = 104,
				M4_E1_4 = 105,
				M4_E1_8 = 106,
				M4_E1_16 = 107,
				M5_E8 = 108,
				M5_E4 = 109,
				M5_E2 = 110,
				M5_E3_2 = 111,
				M5_E1 = 112,
				M5_E1_2 = 113,
				M5_E1_4 = 114,
				M5_E1_8 = 115,
				M5_E1_16 = 116,
				M6_E8 = 117,
				M6_E4 = 118,
				M6_E2 = 119,
				M6_E3_2 = 120,
				M6_E1 = 121,
				M6_E1_2 = 122,
				M6_E1_4 = 123,
				M6_E1_8 = 124,
				M6_E1_16 = 125,
				M7_E8 = 126,
				M7_E4 = 127,
				M7_E2 = 128,
				M7_E3_2 = 129,
				M7_E1 = 130,
				M7_E1_2 = 131,
				M7_E1_4 = 132,
				M7_E1_8 = 133,
				M7_E1_16 = 134,
				H1_E8 = 135,
				H1_E4 = 136,
				H1_E2 = 137,
				H1_E3_2 = 138,
				H1_E1 = 139,
				H1_E1_2 = 140,
				H1_E1_4 = 141,
				H1_E1_8 = 142,
				H1_E1_16 = 143,
				H2_E8 = 144,
				H2_E4 = 145,
				H2_E2 = 146,
				H2_E3_2 = 147,
				H2_E1 = 148,
				H2_E1_2 = 149,
				H2_E1_4 = 150,
				H2_E1_8 = 151,
				H2_E1_16 = 152,
				H3_E8 = 153,
				H3_E4 = 154,
				H3_E2 = 155,
				H3_E3_2 = 156,
				H3_E1 = 157,
				H3_E1_2 = 158,
				H3_E1_4 = 159,
				H3_E1_8 = 160,
				H3_E1_16 = 161,
				H4_E8 = 162,
				H4_E4 = 163,
				H4_E2 = 164,
				H4_E3_2 = 165,
				H4_E1 = 166,
				H4_E1_2 = 167,
				H4_E1_4 = 168,
				H4_E1_8 = 169,
				H4_E1_16 = 170,
				H5_E8 = 171,
				H5_E4 = 172,
				H5_E2 = 173,
				H5_E3_2 = 174,
				H5_E1 = 175,
				H5_E1_2 = 176,
				H5_E1_4 = 177,
				H5_E1_8 = 178,
				H5_E1_16 = 179,
				H6_E8 = 180,
				H6_E4 = 181,
				H6_E2 = 182,
				H6_E3_2 = 183,
				H6_E1 = 184,
				H6_E1_2 = 185,
				H6_E1_4 = 186,
				H6_E1_8 = 187,
				H6_E1_16 = 188,
				H7_E8 = 189,
				H7_E4 = 190,
				H7_E2 = 191,
				H7_E3_2 = 192,
				H7_E1 = 193,
				H7_E1_2 = 194,
				H7_E1_4 = 195,
				H7_E1_8 = 196,
				H7_E1_16 = 197;


	// 是否切换了歌???
	reg press;
	reg [7:0]flag_old;
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			press <= 0;
		end else begin
			if (flag_old != flag) begin
				press <= 1;
			end else begin
				press <= 0;
			end
			flag_old <= flag;
		end
	end
	
	//歌曲种类标志???
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			flag <= 0;
		end	else begin
			flag <= song;
		end
	end
	
	//重设音符的个???
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			YINFU <= 48;
		end else begin
			case (flag)
				0: YINFU <= 48; 
				1: YINFU <= 36;
				2: YINFU <= 203;
				3: YINFU <= 76;
				4: YINFU <= 29;
				5: YINFU <= 65;
				6 : YINFU <= 55;
				default: YINFU <= 48; // 默认小星???
			endcase
		end
	end
	
	//计数每个音符的周期，也就是表示音符的???个周???
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt0 <= 0;
		end
		else if(press)
			cnt0 <= 0;
		else begin
			if(cnt0 == pre_set - 1)
				cnt0 <= 0;
			else
				cnt0 <= cnt0 + 1;
		end
	end
	
	//计数每个音符重复次数，也就是表示???个音符的响鸣持续时长
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt1 <= 0;
		end
		else if(press)
			cnt1 <= 0;
		else begin
			if(cnt0 == pre_set - 1)begin
				if(cnt1 == cishu)//TODO:次数改
					cnt1 <= 0;
				else
					cnt1 <= cnt1 + 1;
			end
		end
	end
	
	//计数有多少个音符，也就是曲谱中有共多少个音符
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt2 <= 0;
		end
		else if(press)
			cnt2 <= 0;
		else begin
			if(cnt1 == cishu && cnt0 == pre_set - 1) begin
				if(cnt2 == YINFU - 1) begin
					cnt2 <= 0;
				end
				else
					cnt2 <= cnt2 + 1;
			end
		end
	end
	
	//定义音符重复次数
	 always @(*) begin
		case(note_type)
			L1_E8:cishu=1000;
			L1_E4:cishu=500;
			L1_E2:cishu=250;
			L1_E3_2:cishu=187;
			L1_E1:cishu=125;
			L1_E1_2:cishu=62;
			L1_E1_4:cishu=31;
			L1_E1_8:cishu=15;
			L1_E1_16:cishu=7;
			L2_E8:cishu=1120;
			L2_E4:cishu=560;
			L2_E2:cishu=280;
			L2_E3_2:cishu=210;
			L2_E1:cishu=140;
			L2_E1_2:cishu=70;
			L2_E1_4:cishu=35;
			L2_E1_8:cishu=17;
			L2_E1_16:cishu=8;
			L3_E8:cishu=1264;
			L3_E4:cishu=632;
			L3_E2:cishu=316;
			L3_E3_2:cishu=237;
			L3_E1:cishu=158;
			L3_E1_2:cishu=79;
			L3_E1_4:cishu=39;
			L3_E1_8:cishu=19;
			L3_E1_16:cishu=9;
			L4_E8:cishu=1336;
			L4_E4:cishu=668;
			L4_E2:cishu=334;
			L4_E3_2:cishu=250;
			L4_E1:cishu=167;
			L4_E1_2:cishu=83;
			L4_E1_4:cishu=41;
			L4_E1_8:cishu=20;
			L4_E1_16:cishu=10;
			L5_E8:cishu=1496;
			L5_E4:cishu=748;
			L5_E2:cishu=374;
			L5_E3_2:cishu=280;
			L5_E1:cishu=187;
			L5_E1_2:cishu=93;
			L5_E1_4:cishu=46;
			L5_E1_8:cishu=23;
			L5_E1_16:cishu=11;
			L6_E8:cishu=1680;
			L6_E4:cishu=840;
			L6_E2:cishu=420;
			L6_E3_2:cishu=315;
			L6_E1:cishu=210;
			L6_E1_2:cishu=105;
			L6_E1_4:cishu=52;
			L6_E1_8:cishu=26;
			L6_E1_16:cishu=13;
			L7_E8:cishu=1968;
			L7_E4:cishu=984;
			L7_E2:cishu=492;
			L7_E3_2:cishu=369;
			L7_E1:cishu=246;
			L7_E1_2:cishu=123;
			L7_E1_4:cishu=61;
			L7_E1_8:cishu=30;
			L7_E1_16:cishu=15;
			M0_E8:cishu=1936;
			M0_E4:cishu=968;
			M0_E2:cishu=484;
			M0_E3_2:cishu=363;
			M0_E1:cishu=242;
			M0_E1_2:cishu=121;
			M0_E1_4:cishu=60;
			M0_E1_8:cishu=30;
			M0_E1_16:cishu=15;
			M1_E8:cishu=2000;
			M1_E4:cishu=1000;
			M1_E2:cishu=500;
			M1_E3_2:cishu=375;
			M1_E1:cishu=250;
			M1_E1_2:cishu=125;
			M1_E1_4:cishu=62;
			M1_E1_8:cishu=31;
			M1_E1_16:cishu=15;
			M2_E8:cishu=2248;
			M2_E4:cishu=1124;
			M2_E2:cishu=562;
			M2_E3_2:cishu=421;
			M2_E1:cishu=281;
			M2_E1_2:cishu=140;
			M2_E1_4:cishu=70;
			M2_E1_8:cishu=35;
			M2_E1_16:cishu=17;
			M3_E8:cishu=2520;
			M3_E4:cishu=1260;
			M3_E2:cishu=630;
			M3_E3_2:cishu=472;
			M3_E1:cishu=315;
			M3_E1_2:cishu=157;
			M3_E1_4:cishu=78;
			M3_E1_8:cishu=39;
			M3_E1_16:cishu=19;
			M4_E8:cishu=2672;
			M4_E4:cishu=1336;
			M4_E2:cishu=668;
			M4_E3_2:cishu=501;
			M4_E1:cishu=334;
			M4_E1_2:cishu=167;
			M4_E1_4:cishu=83;
			M4_E1_8:cishu=41;
			M4_E1_16:cishu=20;
			M5_E8:cishu=3000;
			M5_E4:cishu=1500;
			M5_E2:cishu=750;
			M5_E3_2:cishu=562;
			M5_E1:cishu=375;
			M5_E1_2:cishu=187;
			M5_E1_4:cishu=93;
			M5_E1_8:cishu=46;
			M5_E1_16:cishu=23;
			M6_E8:cishu=3368;
			M6_E4:cishu=1684;
			M6_E2:cishu=842;
			M6_E3_2:cishu=631;
			M6_E1:cishu=421;
			M6_E1_2:cishu=210;
			M6_E1_4:cishu=105;
			M6_E1_8:cishu=52;
			M6_E1_16:cishu=26;
			M7_E8:cishu=3776;
			M7_E4:cishu=1888;
			M7_E2:cishu=944;
			M7_E3_2:cishu=708;
			M7_E1:cishu=472;
			M7_E1_2:cishu=236;
			M7_E1_4:cishu=118;
			M7_E1_8:cishu=59;
			M7_E1_16:cishu=29;
			H1_E8:cishu=4008;
			H1_E4:cishu=2004;
			H1_E2:cishu=1002;
			H1_E3_2:cishu=751;
			H1_E1:cishu=501;
			H1_E1_2:cishu=250;
			H1_E1_4:cishu=125;
			H1_E1_8:cishu=62;
			H1_E1_16:cishu=31;
			H2_E8:cishu=4496;
			H2_E4:cishu=2248;
			H2_E2:cishu=1124;
			H2_E3_2:cishu=843;
			H2_E1:cishu=562;
			H2_E1_2:cishu=281;
			H2_E1_4:cishu=140;
			H2_E1_8:cishu=70;
			H2_E1_16:cishu=35;
			H3_E8:cishu=5040;
			H3_E4:cishu=2520;
			H3_E2:cishu=1260;
			H3_E3_2:cishu=945;
			H3_E1:cishu=630;
			H3_E1_2:cishu=315;
			H3_E1_4:cishu=157;
			H3_E1_8:cishu=78;
			H3_E1_16:cishu=39;
			H4_E8:cishu=5088;
			H4_E4:cishu=2544;
			H4_E2:cishu=1272;
			H4_E3_2:cishu=954;
			H4_E1:cishu=636;
			H4_E1_2:cishu=318;
			H4_E1_4:cishu=159;
			H4_E1_8:cishu=79;
			H4_E1_16:cishu=39;
			H5_E8:cishu=6000;
			H5_E4:cishu=3000;
			H5_E2:cishu=1500;
			H5_E3_2:cishu=1125;
			H5_E1:cishu=750;
			H5_E1_2:cishu=375;
			H5_E1_4:cishu=187;
			H5_E1_8:cishu=93;
			H5_E1_16:cishu=46;
			H6_E8:cishu=6728;
			H6_E4:cishu=3364;
			H6_E2:cishu=1682;
			H6_E3_2:cishu=1261;
			H6_E1:cishu=841;
			H6_E1_2:cishu=420;
			H6_E1_4:cishu=210;
			H6_E1_8:cishu=105;
			H6_E1_16:cishu=52;
			H7_E8:cishu=7528;
			H7_E4:cishu=3764;
			H7_E2:cishu=1882;
			H7_E3_2:cishu=1411;
			H7_E1:cishu=941;
			H7_E1_2:cishu=470;
			H7_E1_4:cishu=235;
			H7_E1_8:cishu=117;
			H7_E1_16:cishu=58;


			default: cishu = 250;
		endcase
	end
	
	//曲谱定义
	always @(*) begin
		case (flag)
			0: begin
				case(cnt2)	//小星星歌???
					0 : begin pre_set <= M1; note_type <= M1_E1; end
					1 : begin pre_set <= M1; note_type <= M1_E1; end
					2 : begin pre_set <= M5; note_type <= M5_E1; end
					3 : begin pre_set <= M5; note_type <= M5_E1; end
					4 : begin pre_set <= M6; note_type <= M6_E1; end
					5 : begin pre_set <= M6; note_type <= M6_E1; end
					6 : begin pre_set <= M5; note_type <= M5_E1; end
					7 : begin pre_set <= M0; note_type <= M0_E1; end
					8 : begin pre_set <= M4; note_type <= M4_E1; end
					9 : begin pre_set <= M4; note_type <= M4_E1; end
					10 : begin pre_set <= M3; note_type <= M3_E1; end
					11 : begin pre_set <= M3; note_type <= M3_E1; end
					12 : begin pre_set <= M2; note_type <= M2_E1; end
					13 : begin pre_set <= M2; note_type <= M2_E1; end
					14 : begin pre_set <= M1; note_type <= M1_E1; end
					15 : begin pre_set <= M0; note_type <= M0_E1; end
					16 : begin pre_set <= M5; note_type <= M5_E1; end
					17 : begin pre_set <= M5; note_type <= M5_E1; end
					18 : begin pre_set <= M4; note_type <= M4_E1; end
					19 : begin pre_set <= M4; note_type <= M4_E1; end
					20 : begin pre_set <= M3; note_type <= M3_E1; end
					21 : begin pre_set <= M3; note_type <= M3_E1; end
					22 : begin pre_set <= M2; note_type <= M2_E1; end
					23 : begin pre_set <= M0; note_type <= M0_E1; end
					24 : begin pre_set <= M5; note_type <= M5_E1; end
					25 : begin pre_set <= M5; note_type <= M5_E1; end
					26 : begin pre_set <= M4; note_type <= M4_E1; end
					27 : begin pre_set <= M4; note_type <= M4_E1; end
					28 : begin pre_set <= M3; note_type <= M3_E1; end
					29 : begin pre_set <= M3; note_type <= M3_E1; end
					30 : begin pre_set <= M2; note_type <= M2_E1; end
					31 : begin pre_set <= M0; note_type <= M0_E1; end
					32 : begin pre_set <= M1; note_type <= M1_E1; end
					33 : begin pre_set <= M1; note_type <= M1_E1; end
					34 : begin pre_set <= M5; note_type <= M5_E1; end
					35 : begin pre_set <= M5; note_type <= M5_E1; end
					36 : begin pre_set <= M6; note_type <= M6_E1; end
					37 : begin pre_set <= M6; note_type <= M6_E1; end
					38 : begin pre_set <= M5; note_type <= M5_E1; end
					39 : begin pre_set <= M0; note_type <= M0_E1; end
					40 : begin pre_set <= M4; note_type <= M4_E1; end
					41 : begin pre_set <= M4; note_type <= M4_E1; end
					42 : begin pre_set <= M3; note_type <= M3_E1; end
					43 : begin pre_set <= M3; note_type <= M3_E1; end
					44 : begin pre_set <= M2; note_type <= M2_E1; end
					45 : begin pre_set <= M2; note_type <= M2_E1; end
					46 : begin pre_set <= M1; note_type <= M1_E1; end
					47 : begin pre_set <= M0; note_type <= M0_E1; end

			endcase
			end
			1: begin
				case(cnt2)	//两只老虎歌谱
					0 : begin pre_set <= M1; note_type <= M1_E1; end
					1 : begin pre_set <= M2; note_type <= M2_E1; end
					2 : begin pre_set <= M3; note_type <= M3_E1; end
					3 : begin pre_set <= M1; note_type <= M1_E1; end
					4 : begin pre_set <= M1; note_type <= M1_E1; end
					5 : begin pre_set <= M2; note_type <= M2_E1; end
					6 : begin pre_set <= M3; note_type <= M3_E1; end
					7 : begin pre_set <= M1; note_type <= M1_E1; end
					8 : begin pre_set <= M3; note_type <= M3_E1; end
					9 : begin pre_set <= M4; note_type <= M4_E1; end
					10 : begin pre_set <= M5; note_type <= M5_E1; end
					11 : begin pre_set <= M0; note_type <= M0_E1; end
					12 : begin pre_set <= M3; note_type <= M3_E1; end
					13 : begin pre_set <= M4; note_type <= M4_E1; end
					14 : begin pre_set <= M5; note_type <= M5_E1; end
					15 : begin pre_set <= M0; note_type <= M0_E1; end
					16 : begin pre_set <= M5; note_type <= M5_E1; end
					17 : begin pre_set <= M6; note_type <= M6_E1; end
					18 : begin pre_set <= M5; note_type <= M5_E1; end
					19 : begin pre_set <= M4; note_type <= M4_E1; end
					20 : begin pre_set <= M3; note_type <= M3_E1; end
					21 : begin pre_set <= M1; note_type <= M1_E1; end
					22 : begin pre_set <= M5; note_type <= M5_E1; end
					23 : begin pre_set <= M6; note_type <= M6_E1; end
					24 : begin pre_set <= M5; note_type <= M5_E1; end
					25 : begin pre_set <= M4; note_type <= M4_E1; end
					26 : begin pre_set <= M3; note_type <= M3_E1; end
					27 : begin pre_set <= M1; note_type <= M1_E1; end
					28 : begin pre_set <= M2; note_type <= M2_E1; end
					29 : begin pre_set <= M5; note_type <= M5_E1; end
					30 : begin pre_set <= M1; note_type <= M1_E1; end
					31 : begin pre_set <= M0; note_type <= M0_E1; end
					32 : begin pre_set <= M2; note_type <= M2_E1; end
					33 : begin pre_set <= M5; note_type <= M5_E1; end
					34 : begin pre_set <= M1; note_type <= M1_E1; end
					35 : begin pre_set <= M0; note_type <= M0_E1; end

				endcase
			end
			2: begin // 云宫迅因
				case(cnt2) 
					0 : begin pre_set <= L6; note_type <= L6_E1_2; end
					1 : begin pre_set <= L6; note_type <= L6_E1_2; end
					2 : begin pre_set <= L3; note_type <= L3_E1_2; end
					3 : begin pre_set <= L5; note_type <= L5_E1_2; end
					4 : begin pre_set <= M1; note_type <= M1_E1_2; end
					5 : begin pre_set <= L6; note_type <= L6_E1_2; end
					6 : begin pre_set <= L3; note_type <= L3_E1_2; end
					7 : begin pre_set <= L5; note_type <= L5_E1_2; end
					8 : begin pre_set <= L6; note_type <= L6_E1_2; end
					9 : begin pre_set <= L6; note_type <= L6_E1_2; end
					10 : begin pre_set <= L3; note_type <= L3_E1_2; end
					11 : begin pre_set <= L5; note_type <= L5_E1_2; end
					12 : begin pre_set <= M1; note_type <= M1_E1_2; end
					13 : begin pre_set <= L6; note_type <= L6_E1_2; end
					14 : begin pre_set <= L3; note_type <= L3_E1_2; end
					15 : begin pre_set <= L5; note_type <= L5_E1_2; end
					16 : begin pre_set <= L6; note_type <= L6_E1_2; end
					17 : begin pre_set <= L6; note_type <= L6_E1_2; end
					18 : begin pre_set <= L3; note_type <= L3_E1_2; end
					19 : begin pre_set <= L5; note_type <= L5_E1_2; end
					20 : begin pre_set <= M1; note_type <= M1_E1_2; end
					21 : begin pre_set <= L6; note_type <= L6_E1_2; end
					22 : begin pre_set <= L3; note_type <= L3_E1_2; end
					23 : begin pre_set <= L5; note_type <= L5_E1_2; end
					24 : begin pre_set <= L6; note_type <= L6_E1_2; end
					25 : begin pre_set <= L6; note_type <= L6_E1_2; end
					26 : begin pre_set <= L3; note_type <= L3_E1_2; end
					27 : begin pre_set <= L5; note_type <= L5_E1_2; end
					28 : begin pre_set <= M1; note_type <= M1_E1_2; end
					29 : begin pre_set <= L6; note_type <= L6_E1_2; end
					30 : begin pre_set <= L3; note_type <= L3_E1_2; end
					31 : begin pre_set <= L5; note_type <= L5_E1_2; end
					32 : begin pre_set <= L6; note_type <= L6_E1_2; end
					33 : begin pre_set <= L6; note_type <= L6_E1_2; end
					34 : begin pre_set <= L4; note_type <= L4_E1_2; end
					35 : begin pre_set <= L5; note_type <= L5_E1_2; end
					36 : begin pre_set <= M1; note_type <= M1_E1_2; end
					37 : begin pre_set <= L6; note_type <= L6_E1_2; end
					38 : begin pre_set <= L4; note_type <= L4_E1_2; end
					39 : begin pre_set <= L5; note_type <= L5_E1_2; end
					40 : begin pre_set <= L6; note_type <= L6_E1_2; end
					41 : begin pre_set <= L6; note_type <= L6_E1_2; end
					42 : begin pre_set <= L4; note_type <= L4_E1_2; end
					43 : begin pre_set <= L5; note_type <= L5_E1_2; end
					44 : begin pre_set <= M1; note_type <= M1_E1_2; end
					45 : begin pre_set <= L6; note_type <= L6_E1_2; end
					46 : begin pre_set <= L4; note_type <= L4_E1_2; end
					47 : begin pre_set <= L5; note_type <= L5_E1_2; end
					48 : begin pre_set <= L6; note_type <= L6_E1_2; end
					49 : begin pre_set <= L6; note_type <= L6_E1_2; end
					50 : begin pre_set <= L4; note_type <= L4_E1_2; end
					51 : begin pre_set <= L5; note_type <= L5_E1_2; end
					52 : begin pre_set <= M1; note_type <= M1_E1_2; end
					53 : begin pre_set <= L6; note_type <= L6_E1_2; end
					54 : begin pre_set <= L4; note_type <= L4_E1_2; end
					55 : begin pre_set <= L5; note_type <= L5_E1_2; end
					56 : begin pre_set <= L6; note_type <= L6_E1_2; end
					57 : begin pre_set <= L6; note_type <= L6_E1_2; end
					58 : begin pre_set <= L4; note_type <= L4_E1_2; end
					59 : begin pre_set <= L5; note_type <= L5_E1_2; end
					60 : begin pre_set <= M1; note_type <= M1_E1_2; end
					61 : begin pre_set <= L6; note_type <= L6_E1_2; end
					62 : begin pre_set <= L4; note_type <= L4_E1_2; end
					63 : begin pre_set <= L5; note_type <= L5_E1_2; end
					64 : begin pre_set <= L6; note_type <= L6_E1_2; end
					65 : begin pre_set <= L6; note_type <= L6_E1_2; end
					66 : begin pre_set <= L4; note_type <= L4_E1_2; end
					67 : begin pre_set <= L5; note_type <= L5_E1_2; end
					68 : begin pre_set <= M1; note_type <= M1_E1_2; end
					69 : begin pre_set <= M3; note_type <= M3_E1_2; end
					70 : begin pre_set <= M6; note_type <= M6_E1_2; end
					71 : begin pre_set <= H1; note_type <= H1_E1_2; end
					72 : begin pre_set <= M6; note_type <= M6_E1; end
					73 : begin pre_set <= M3; note_type <= M3_E1; end
					74 : begin pre_set <= M0; note_type <= M0_E1_2; end
					75 : begin pre_set <= M3; note_type <= M3_E1_2; end
					76 : begin pre_set <= M6; note_type <= M6_E1_2; end
					77 : begin pre_set <= H1; note_type <= H1_E1_2; end
					78 : begin pre_set <= M6; note_type <= M6_E1; end
					79 : begin pre_set <= M0; note_type <= M0_E1; end
					80 : begin pre_set <= M0; note_type <= M0_E1_2; end
					81 : begin pre_set <= M3; note_type <= M3_E1_2; end
					82 : begin pre_set <= M6; note_type <= M6_E1_2; end
					83 : begin pre_set <= H1; note_type <= H1_E1_2; end
					84 : begin pre_set <= H2; note_type <= H2_E1; end
					85 : begin pre_set <= M0; note_type <= M0_E1; end
					86 : begin pre_set <= M0; note_type <= M0_E1_2; end
					87 : begin pre_set <= M4; note_type <= M4_E1_2; end
					88 : begin pre_set <= M6; note_type <= M6_E1_2; end
					89 : begin pre_set <= H1; note_type <= H1_E1_2; end
					90 : begin pre_set <= H2; note_type <= H2_E1; end
					91 : begin pre_set <= M6; note_type <= M6_E1; end
					92 : begin pre_set <= H1; note_type <= H1_E1; end
					93 : begin pre_set <= H2; note_type <= H2_E1; end
					94 : begin pre_set <= H4; note_type <= H4_E1; end
					95 : begin pre_set <= H1; note_type <= H1_E1; end
					96 : begin pre_set <= H2; note_type <= H2_E1; end
					97 : begin pre_set <= H4; note_type <= H4_E1; end
					98 : begin pre_set <= H3; note_type <= H3_E4; end
					99 : begin pre_set <= M3; note_type <= M3_E2; end
					100 : begin pre_set <= M6; note_type <= M6_E3_2; end
					101 : begin pre_set <= M7; note_type <= M7_E1_2; end
					102 : begin pre_set <= H1; note_type <= H1_E1; end
					103 : begin pre_set <= M6; note_type <= M6_E1; end
					104 : begin pre_set <= H4; note_type <= H4_E3_2; end
					105 : begin pre_set <= H2; note_type <= H2_E1_2; end
					106 : begin pre_set <= H3; note_type <= H3_E4; end
					107 : begin pre_set <= M3; note_type <= M3_E2; end
					108 : begin pre_set <= M6; note_type <= M6_E3_2; end
					109 : begin pre_set <= M7; note_type <= M7_E1_2; end
					110 : begin pre_set <= H1; note_type <= H1_E1; end
					111 : begin pre_set <= M6; note_type <= M6_E1; end
					112 : begin pre_set <= H4; note_type <= H4_E3_2; end
					113 : begin pre_set <= H3; note_type <= H3_E1_2; end
					114 : begin pre_set <= H2; note_type <= H2_E4; end
					115 : begin pre_set <= M0; note_type <= M0_E1; end
					116 : begin pre_set <= H3; note_type <= H3_E1; end
					117 : begin pre_set <= H2; note_type <= H2_E3_2; end
					118 : begin pre_set <= H1; note_type <= H1_E1_2; end
					119 : begin pre_set <= H3; note_type <= H3_E4; end
					120 : begin pre_set <= M0; note_type <= M0_E1; end
					121 : begin pre_set <= H2; note_type <= H2_E1; end
					122 : begin pre_set <= H1; note_type <= H1_E3_2; end
					123 : begin pre_set <= M7; note_type <= M7_E1_2; end
					124 : begin pre_set <= H2; note_type <= H2_E4; end
					125 : begin pre_set <= M0; note_type <= M0_E1; end
					126 : begin pre_set <= H4; note_type <= H4_E1; end
					127 : begin pre_set <= H3; note_type <= H3_E1; end
					128 : begin pre_set <= H2; note_type <= H2_E1; end
					129 : begin pre_set <= H5; note_type <= H5_E2; end
					130 : begin pre_set <= H4; note_type <= H4_E1; end
					131 : begin pre_set <= H3; note_type <= H3_E2; end
					132 : begin pre_set <= H2; note_type <= H2_E1; end
					133 : begin pre_set <= H3; note_type <= H3_E4; end
					134 : begin pre_set <= M3; note_type <= M3_E2; end
					135 : begin pre_set <= M6; note_type <= M6_E3_2; end
					136 : begin pre_set <= M7; note_type <= M7_E1_2; end
					137 : begin pre_set <= H1; note_type <= H1_E1; end
					138 : begin pre_set <= M6; note_type <= M6_E1; end
					139 : begin pre_set <= H4; note_type <= H4_E3_2; end
					140 : begin pre_set <= H2; note_type <= H2_E1_2; end
					141 : begin pre_set <= H3; note_type <= H3_E4; end
					142 : begin pre_set <= M3; note_type <= M3_E2; end
					143 : begin pre_set <= M6; note_type <= M6_E3_2; end
					144 : begin pre_set <= M7; note_type <= M7_E1_2; end
					145 : begin pre_set <= H1; note_type <= H1_E1; end
					146 : begin pre_set <= M6; note_type <= M6_E1; end
					147 : begin pre_set <= H4; note_type <= H4_E3_2; end
					148 : begin pre_set <= H3; note_type <= H3_E1_2; end
					149 : begin pre_set <= H2; note_type <= H2_E4; end
					150 : begin pre_set <= M3; note_type <= M3_E2; end
					151 : begin pre_set <= M6; note_type <= M6_E3_2; end
					152 : begin pre_set <= M7; note_type <= M7_E1_2; end
					153 : begin pre_set <= H1; note_type <= H1_E1; end
					154 : begin pre_set <= M6; note_type <= M6_E1; end
					155 : begin pre_set <= H4; note_type <= H4_E1; end
					156 : begin pre_set <= H3; note_type <= H3_E1_2; end
					157 : begin pre_set <= H2; note_type <= H2_E1_2; end
					158 : begin pre_set <= H5; note_type <= H5_E4; end
					159 : begin pre_set <= M3; note_type <= M3_E2; end
					160 : begin pre_set <= M6; note_type <= M6_E3_2; end
					161 : begin pre_set <= M7; note_type <= M7_E1_2; end
					162 : begin pre_set <= H1; note_type <= H1_E1; end
					163 : begin pre_set <= M6; note_type <= M6_E1; end
					164 : begin pre_set <= H4; note_type <= H4_E1; end
					165 : begin pre_set <= H3; note_type <= H3_E1; end
					166 : begin pre_set <= H2; note_type <= H2_E1; end
					167 : begin pre_set <= H5; note_type <= H5_E4; end
					168 : begin pre_set <= M0; note_type <= M0_E1; end
					169 : begin pre_set <= H3; note_type <= H3_E1; end
					170 : begin pre_set <= H2; note_type <= H2_E3_2; end
					171 : begin pre_set <= H1; note_type <= H1_E1_2; end
					172 : begin pre_set <= H3; note_type <= H3_E4; end
					173 : begin pre_set <= M0; note_type <= M0_E1; end
					174 : begin pre_set <= H2; note_type <= H2_E1; end
					175 : begin pre_set <= H1; note_type <= H1_E3_2; end
					176 : begin pre_set <= M7; note_type <= M7_E1_2; end
					177 : begin pre_set <= H2; note_type <= H2_E4; end
					178 : begin pre_set <= M0; note_type <= M0_E1; end
					179 : begin pre_set <= H4; note_type <= H4_E1; end
					180 : begin pre_set <= H3; note_type <= H3_E1; end
					181 : begin pre_set <= H2; note_type <= H2_E1; end
					182 : begin pre_set <= H5; note_type <= H5_E2; end
					183 : begin pre_set <= H4; note_type <= H4_E1; end
					184 : begin pre_set <= H3; note_type <= H3_E2; end
					185 : begin pre_set <= H2; note_type <= H2_E1; end
					186 : begin pre_set <= H3; note_type <= H3_E4; end
					187 : begin pre_set <= M3; note_type <= M3_E2; end
					188 : begin pre_set <= M6; note_type <= M6_E3_2; end
					189 : begin pre_set <= M7; note_type <= M7_E1_2; end
					190 : begin pre_set <= H1; note_type <= H1_E1; end
					191 : begin pre_set <= M6; note_type <= M6_E1; end
					192 : begin pre_set <= H4; note_type <= H4_E3_2; end
					193 : begin pre_set <= H2; note_type <= H2_E1_2; end
					194 : begin pre_set <= H3; note_type <= H3_E4; end
					195 : begin pre_set <= M3; note_type <= M3_E2; end
					196 : begin pre_set <= M6; note_type <= M6_E3_2; end
					197 : begin pre_set <= M7; note_type <= M7_E1_2; end
					198 : begin pre_set <= H1; note_type <= H1_E1; end
					199 : begin pre_set <= M6; note_type <= M6_E1; end
					200 : begin pre_set <= H4; note_type <= H4_E3_2; end
					201 : begin pre_set <= H3; note_type <= H3_E1_2; end
					202 : begin pre_set <= H2; note_type <= H2_E4; end

				endcase
			end

			3: begin
				case (cnt2)
					0 : begin pre_set <= L6; note_type <= L6_E1_2; end
					1 : begin pre_set <= L7; note_type <= L7_E1_2; end
					2 : begin pre_set <= M1; note_type <= M1_E3_2; end
					3 : begin pre_set <= L7; note_type <= L7_E1_2; end
					4 : begin pre_set <= M1; note_type <= M1_E1; end
					5 : begin pre_set <= M3; note_type <= M3_E1; end
					6 : begin pre_set <= L7; note_type <= L7_E2; end
					7 : begin pre_set <= M0; note_type <= M0_E1; end
					8 : begin pre_set <= L3; note_type <= L3_E1; end
					9 : begin pre_set <= L6; note_type <= L6_E3_2; end
					10 : begin pre_set <= L5; note_type <= L5_E1_2; end
					11 : begin pre_set <= L6; note_type <= L6_E1; end
					12 : begin pre_set <= M1; note_type <= M1_E1; end
					13 : begin pre_set <= L5; note_type <= L5_E2; end
					14 : begin pre_set <= M0; note_type <= M0_E1; end
					15 : begin pre_set <= L3; note_type <= L3_E1; end
					16 : begin pre_set <= L4; note_type <= L4_E3_2; end
					17 : begin pre_set <= L3; note_type <= L3_E1_2; end
					18 : begin pre_set <= L4; note_type <= L4_E1_2; end
					19 : begin pre_set <= M1; note_type <= M1_E3_2; end
					20 : begin pre_set <= L3; note_type <= L3_E2; end
					21 : begin pre_set <= M0; note_type <= M0_E1; end
					22 : begin pre_set <= M1; note_type <= M1_E1; end
					23 : begin pre_set <= L7; note_type <= L7_E3_2; end
					24 : begin pre_set <= L4; note_type <= L4_E1_2; end
					25 : begin pre_set <= L4; note_type <= L4_E1; end
					26 : begin pre_set <= L7; note_type <= L7_E1; end
					27 : begin pre_set <= L7; note_type <= L7_E2; end
					28 : begin pre_set <= M0; note_type <= M0_E1; end
					29 : begin pre_set <= L6; note_type <= L6_E1_2; end
					30 : begin pre_set <= L7; note_type <= L7_E1_2; end
					31 : begin pre_set <= M1; note_type <= M1_E3_2; end
					32 : begin pre_set <= L7; note_type <= L7_E1_2; end
					33 : begin pre_set <= M1; note_type <= M1_E1; end
					34 : begin pre_set <= M3; note_type <= M3_E1; end
					35 : begin pre_set <= L7; note_type <= L7_E2; end
					36 : begin pre_set <= M0; note_type <= M0_E1; end
					37 : begin pre_set <= L3; note_type <= L3_E1_2; end
					38 : begin pre_set <= L3; note_type <= L3_E1_2; end
					39 : begin pre_set <= L6; note_type <= L6_E3_2; end
					40 : begin pre_set <= L5; note_type <= L5_E1_2; end
					41 : begin pre_set <= L6; note_type <= L6_E1; end
					42 : begin pre_set <= M1; note_type <= M1_E1; end
					43 : begin pre_set <= L5; note_type <= L5_E2; end
					44 : begin pre_set <= M0; note_type <= M0_E1; end
					45 : begin pre_set <= L3; note_type <= L3_E1; end
					46 : begin pre_set <= L4; note_type <= L4_E1; end
					47 : begin pre_set <= M1; note_type <= M1_E1_2; end
					48 : begin pre_set <= L7; note_type <= L7_E3_2; end
					49 : begin pre_set <= M1; note_type <= M1_E1; end
					50 : begin pre_set <= M2; note_type <= M2_E1; end
					51 : begin pre_set <= M3; note_type <= M3_E1_2; end
					52 : begin pre_set <= M1; note_type <= M1_E1_2; end
					53 : begin pre_set <= M1; note_type <= M1_E2; end
					54 : begin pre_set <= M1; note_type <= M1_E1_2; end
					55 : begin pre_set <= L7; note_type <= L7_E1_2; end
					56 : begin pre_set <= L6; note_type <= L6_E1; end
					57 : begin pre_set <= L7; note_type <= L7_E1; end
					58 : begin pre_set <= L5; note_type <= L5_E1; end
					59 : begin pre_set <= L6; note_type <= L6_E2; end
					60 : begin pre_set <= M0; note_type <= M0_E1; end
					61 : begin pre_set <= M1; note_type <= M1_E1_2; end
					62 : begin pre_set <= M2; note_type <= M2_E1_2; end
					63 : begin pre_set <= M3; note_type <= M3_E3_2; end
					64 : begin pre_set <= M2; note_type <= M2_E1_2; end
					65 : begin pre_set <= M3; note_type <= M3_E1; end
					66 : begin pre_set <= M5; note_type <= M5_E1; end
					67 : begin pre_set <= M2; note_type <= M2_E2; end
					68 : begin pre_set <= M0; note_type <= M0_E1; end
					69 : begin pre_set <= L5; note_type <= L5_E1; end
					70 : begin pre_set <= M1; note_type <= M1_E3_2; end
					71 : begin pre_set <= L7; note_type <= L7_E1_2; end
					72 : begin pre_set <= M1; note_type <= M1_E1; end
					73 : begin pre_set <= M2; note_type <= M2_E1_2; end
					74 : begin pre_set <= M3; note_type <= M3_E1_2; end
					75 : begin pre_set <= M3; note_type <= M3_E4; end

				endcase
			end

			4: begin
				case (cnt2)
					0 : begin pre_set <= L6; note_type <= L6_E1_2; end
					1 : begin pre_set <= L5; note_type <= L5_E1_2; end
					2 : begin pre_set <= L5; note_type <= L5_E1_2; end
					3 : begin pre_set <= M3; note_type <= M3_E2; end
					4 : begin pre_set <= M3; note_type <= M3_E1_2; end
					5 : begin pre_set <= M6; note_type <= M6_E1_2; end
					6 : begin pre_set <= M5; note_type <= M5_E1_2; end
					7 : begin pre_set <= M3; note_type <= M3_E1_2; end
					8 : begin pre_set <= M2; note_type <= M2_E2; end
					9 : begin pre_set <= L6; note_type <= L6_E1_2; end
					10 : begin pre_set <= M2; note_type <= M2_E1_2; end
					11 : begin pre_set <= M3; note_type <= M3_E1_2; end
					12 : begin pre_set <= M1; note_type <= M1_E1; end
					13 : begin pre_set <= L6; note_type <= L6_E1_2; end
					14 : begin pre_set <= M1; note_type <= M1_E1_2; end
					15 : begin pre_set <= M2; note_type <= M2_E1_2; end
					16 : begin pre_set <= L7; note_type <= L7_E1_2; end
					17 : begin pre_set <= L5; note_type <= L5_E1_2; end
					18 : begin pre_set <= M6; note_type <= M6_E1_2; end
					19 : begin pre_set <= M5; note_type <= M5_E1_2; end
					20 : begin pre_set <= M3; note_type <= M3_E3_2; end
					21 : begin pre_set <= M2; note_type <= M2_E1_4; end
					22 : begin pre_set <= M3; note_type <= M3_E1_4; end
					23 : begin pre_set <= M5; note_type <= M5_E1_4; end
					24 : begin pre_set <= M3; note_type <= M3_E1; end
					25 : begin pre_set <= M0; note_type <= M0_E1_4; end
					26 : begin pre_set <= L6; note_type <= L6_E1_4; end
					27 : begin pre_set <= L5; note_type <= L5_E1_4; end
					28 : begin pre_set <= L6; note_type <= L6_E1_4; end

				endcase
			end

			5: begin//打上花火
				case (cnt2)
					0 : begin pre_set <= M0; note_type <= M0_E1; end
					1 : begin pre_set <= M0; note_type <= M0_E1; end
					2 : begin pre_set <= M0; note_type <= M0_E1; end
					3 : begin pre_set <= M3; note_type <= M3_E1_2; end
					4 : begin pre_set <= M5; note_type <= M5_E1_4; end
					5 : begin pre_set <= M3; note_type <= M3_E1_4; end
					6 : begin pre_set <= M2; note_type <= M2_E1_2; end
					7 : begin pre_set <= M1; note_type <= M1_E1_2; end
					8 : begin pre_set <= L6; note_type <= L6_E1_4; end
					9 : begin pre_set <= M1; note_type <= M1_E1_2; end
					10 : begin pre_set <= M2; note_type <= M2_E1_2; end
					11 : begin pre_set <= M0; note_type <= M0_E1_2; end
					12 : begin pre_set <= M3; note_type <= M3_E1_2; end
					13 : begin pre_set <= M5; note_type <= M5_E1_4; end
					14 : begin pre_set <= M3; note_type <= M3_E1_4; end
					15 : begin pre_set <= M2; note_type <= M2_E1_2; end
					16 : begin pre_set <= M1; note_type <= M1_E1_2; end
					17 : begin pre_set <= L6; note_type <= L6_E1_4; end
					18 : begin pre_set <= M1; note_type <= M1_E1_2; end
					19 : begin pre_set <= M2; note_type <= M2_E1_2; end
					20 : begin pre_set <= M0; note_type <= M0_E1_2; end
					21 : begin pre_set <= M3; note_type <= M3_E1_2; end
					22 : begin pre_set <= M5; note_type <= M5_E1_4; end
					23 : begin pre_set <= M3; note_type <= M3_E1_4; end
					24 : begin pre_set <= M2; note_type <= M2_E1_2; end
					25 : begin pre_set <= M0; note_type <= M0_E1_2; end
					26 : begin pre_set <= M3; note_type <= M3_E1_4; end
					27 : begin pre_set <= M5; note_type <= M5_E1_2; end
					28 : begin pre_set <= M5; note_type <= M5_E1_2; end
					29 : begin pre_set <= M6; note_type <= M6_E1; end
					30 : begin pre_set <= M5; note_type <= M5_E1_4; end
					31 : begin pre_set <= M4; note_type <= M4_E1_4; end
					32 : begin pre_set <= M3; note_type <= M3_E4; end
					33 : begin pre_set <= M0; note_type <= M0_E1; end
					34 : begin pre_set <= M3; note_type <= M3_E1_2; end
					35 : begin pre_set <= M5; note_type <= M5_E1_4; end
					36 : begin pre_set <= M3; note_type <= M3_E1_4; end
					37 : begin pre_set <= M2; note_type <= M2_E1_2; end
					38 : begin pre_set <= M1; note_type <= M1_E1_2; end
					39 : begin pre_set <= L6; note_type <= L6_E1_4; end
					40 : begin pre_set <= M1; note_type <= M1_E1_2; end
					41 : begin pre_set <= M2; note_type <= M2_E1; end
					42 : begin pre_set <= M0; note_type <= M0_E1_2; end
					43 : begin pre_set <= M3; note_type <= M3_E1_2; end
					44 : begin pre_set <= M5; note_type <= M5_E1_4; end
					45 : begin pre_set <= M3; note_type <= M3_E1_4; end
					46 : begin pre_set <= M2; note_type <= M2_E1_2; end
					47 : begin pre_set <= M1; note_type <= M1_E1_2; end
					48 : begin pre_set <= M6; note_type <= M6_E1_4; end
					49 : begin pre_set <= M1; note_type <= M1_E1_2; end
					50 : begin pre_set <= M1; note_type <= M1_E1_2; end
					51 : begin pre_set <= M0; note_type <= M0_E1_2; end
					52 : begin pre_set <= M1; note_type <= M1_E1_4; end
					53 : begin pre_set <= L7; note_type <= L7_E1_4; end
					54 : begin pre_set <= L6; note_type <= L6_E1_4; end
					55 : begin pre_set <= L7; note_type <= L7_E1_4; end
					56 : begin pre_set <= L6; note_type <= L6_E1; end
					57 : begin pre_set <= L6; note_type <= L6_E1_4; end
					58 : begin pre_set <= M2; note_type <= M2_E1; end
					59 : begin pre_set <= L7; note_type <= L7_E1_2; end
					60 : begin pre_set <= L6; note_type <= L6_E1_2; end
					61 : begin pre_set <= L7; note_type <= L7_E1_2; end
					62 : begin pre_set <= L7; note_type <= L7_E1; end
					63 : begin pre_set <= M1; note_type <= M1_E2; end
					64 : begin pre_set <= M0; note_type <= M0_E1; end

				endcase
			end
			
			6: begin // 只因你太美
				case (cnt2)
					0 : begin pre_set <= M0; note_type <= M0_E1_2; end
					1 : begin pre_set <= L6; note_type <= L6_E1_4; end
					2 : begin pre_set <= L6; note_type <= L6_E1_4; end
					3 : begin pre_set <= M3; note_type <= M3_E1_2; end
					4 : begin pre_set <= M3; note_type <= M3_E1_2; end
					5 : begin pre_set <= L6; note_type <= L6_E1; end
					6 : begin pre_set <= M0; note_type <= M0_E1; end
					7 : begin pre_set <= M0; note_type <= M0_E1; end
					8 : begin pre_set <= M0; note_type <= M0_E1_2; end
					9 : begin pre_set <= L6; note_type <= L6_E1_2; end
					10 : begin pre_set <= L6; note_type <= L6_E1_4; end
					11 : begin pre_set <= L6; note_type <= L6_E1_2; end
					12 : begin pre_set <= M0; note_type <= M0_E1_2; end
					13 : begin pre_set <= M0; note_type <= M0_E1; end
					14 : begin pre_set <= M0; note_type <= M0_E1_2; end
					15 : begin pre_set <= L6; note_type <= L6_E1_4; end
					16 : begin pre_set <= L6; note_type <= L6_E1_4; end
					17 : begin pre_set <= M3; note_type <= M3_E1_2; end
					18 : begin pre_set <= M3; note_type <= M3_E1_2; end
					19 : begin pre_set <= L6; note_type <= L6_E1; end
					20 : begin pre_set <= M0; note_type <= M0_E1; end
					21 : begin pre_set <= M0; note_type <= M0_E1; end
					22 : begin pre_set <= M0; note_type <= M0_E1_2; end
					23 : begin pre_set <= L6; note_type <= L6_E1_4; end
					24 : begin pre_set <= L6; note_type <= L6_E1_4; end
					25 : begin pre_set <= L6; note_type <= L6_E1_2; end
					26 : begin pre_set <= M0; note_type <= M0_E1_2; end
					27 : begin pre_set <= M0; note_type <= M0_E1_2; end
					28 : begin pre_set <= L6; note_type <= L6_E1_4; end
					29 : begin pre_set <= L6; note_type <= L6_E1_4; end
					30 : begin pre_set <= L6; note_type <= L6_E1_2; end
					31 : begin pre_set <= L6; note_type <= L6_E1_4; end
					32 : begin pre_set <= L6; note_type <= L6_E1_4; end
					33 : begin pre_set <= M3; note_type <= M3_E1_2; end
					34 : begin pre_set <= M3; note_type <= M3_E1_2; end
					35 : begin pre_set <= L6; note_type <= L6_E1; end
					36 : begin pre_set <= M0; note_type <= M0_E1; end
					37 : begin pre_set <= M0; note_type <= M0_E1; end
					38 : begin pre_set <= M0; note_type <= M0_E1_2; end
					39 : begin pre_set <= L6; note_type <= L6_E1_4; end
					40 : begin pre_set <= L6; note_type <= L6_E1_4; end
					41 : begin pre_set <= L6; note_type <= L6_E1_2; end
					42 : begin pre_set <= M0; note_type <= M0_E1_2; end
					43 : begin pre_set <= M0; note_type <= M0_E1; end
					44 : begin pre_set <= M0; note_type <= M0_E1_2; end
					45 : begin pre_set <= L6; note_type <= L6_E1_4; end
					46 : begin pre_set <= L6; note_type <= L6_E1_4; end
					47 : begin pre_set <= M3; note_type <= M3_E1_2; end
					48 : begin pre_set <= M3; note_type <= M3_E1_2; end
					49 : begin pre_set <= L6; note_type <= L6_E1; end
					50 : begin pre_set <= M0; note_type <= M0_E1; end
					51 : begin pre_set <= M0; note_type <= M0_E1; end
					52 : begin pre_set <= M0; note_type <= M0_E1_2; end
					53 : begin pre_set <= L6; note_type <= L6_E1_4; end
					54 : begin pre_set <= L6; note_type <= L6_E1_4; end

	
				endcase
			end

			default: begin
				case(cnt2)	//小星星歌???
					0 : begin pre_set <= M1; note_type <= M1_E1; end
					1 : begin pre_set <= M1; note_type <= M1_E1; end
					2 : begin pre_set <= M5; note_type <= M5_E1; end
					3 : begin pre_set <= M5; note_type <= M5_E1; end
					4 : begin pre_set <= M6; note_type <= M6_E1; end
					5 : begin pre_set <= M6; note_type <= M6_E1; end
					6 : begin pre_set <= M5; note_type <= M5_E1; end
					7 : begin pre_set <= M0; note_type <= M0_E1; end
					8 : begin pre_set <= M4; note_type <= M4_E1; end
					9 : begin pre_set <= M4; note_type <= M4_E1; end
					10 : begin pre_set <= M3; note_type <= M3_E1; end
					11 : begin pre_set <= M3; note_type <= M3_E1; end
					12 : begin pre_set <= M2; note_type <= M2_E1; end
					13 : begin pre_set <= M2; note_type <= M2_E1; end
					14 : begin pre_set <= M1; note_type <= M1_E1; end
					15 : begin pre_set <= M0; note_type <= M0_E1; end
					16 : begin pre_set <= M5; note_type <= M5_E1; end
					17 : begin pre_set <= M5; note_type <= M5_E1; end
					18 : begin pre_set <= M4; note_type <= M4_E1; end
					19 : begin pre_set <= M4; note_type <= M4_E1; end
					20 : begin pre_set <= M3; note_type <= M3_E1; end
					21 : begin pre_set <= M3; note_type <= M3_E1; end
					22 : begin pre_set <= M2; note_type <= M2_E1; end
					23 : begin pre_set <= M0; note_type <= M0_E1; end
					24 : begin pre_set <= M5; note_type <= M5_E1; end
					25 : begin pre_set <= M5; note_type <= M5_E1; end
					26 : begin pre_set <= M4; note_type <= M4_E1; end
					27 : begin pre_set <= M4; note_type <= M4_E1; end
					28 : begin pre_set <= M3; note_type <= M3_E1; end
					29 : begin pre_set <= M3; note_type <= M3_E1; end
					30 : begin pre_set <= M2; note_type <= M2_E1; end
					31 : begin pre_set <= M0; note_type <= M0_E1; end
					32 : begin pre_set <= M1; note_type <= M1_E1; end
					33 : begin pre_set <= M1; note_type <= M1_E1; end
					34 : begin pre_set <= M5; note_type <= M5_E1; end
					35 : begin pre_set <= M5; note_type <= M5_E1; end
					36 : begin pre_set <= M6; note_type <= M6_E1; end
					37 : begin pre_set <= M6; note_type <= M6_E1; end
					38 : begin pre_set <= M5; note_type <= M5_E1; end
					39 : begin pre_set <= M0; note_type <= M0_E1; end
					40 : begin pre_set <= M4; note_type <= M4_E1; end
					41 : begin pre_set <= M4; note_type <= M4_E1; end
					42 : begin pre_set <= M3; note_type <= M3_E1; end
					43 : begin pre_set <= M3; note_type <= M3_E1; end
					44 : begin pre_set <= M2; note_type <= M2_E1; end
					45 : begin pre_set <= M2; note_type <= M2_E1; end
					46 : begin pre_set <= M1; note_type <= M1_E1; end
					47 : begin pre_set <= M0; note_type <= M0_E1; end

			endcase
			end
		endcase
	end
	
	assign pre_div = pre_set >> 1;	//除以2
	assign cishu_div = cishu * 4 / 5;
	
	//向蜂鸣器输出脉冲
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			buzzer <= 1'b1;
		end
		else if(pre_set != M0) begin
			if(cnt1 < cishu_div) begin
				if(cnt0 < pre_div) begin
						buzzer <= 1'b1;
				end
				else begin
						buzzer <= 1'b0;
				end
			end
			else begin
				buzzer <= 1'b1;
			end
		end
		else
			buzzer <= 1'b1;
	end
	
endmodule
	

