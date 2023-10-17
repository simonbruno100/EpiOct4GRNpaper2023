function [Xfin,Tfin] = runmeeasyFINAL3DOUBLETRANSIENT(D11_initial,D21_initial,D121_initial,Da1_initial,O_initial,D12_initial,D22_initial,D122_initial,Da2_initial,T_initial,D13_initial,D23_initial,D123_initial,Da3_initial,E_initial);

%%   System reactions

%   1. D1  + P1           --    a              --> Ca1
%   2. Ca1                --    d              --> D1 + P1
%   3. Da1 + P2           --    a              --> Ct1
%   4. Ct1                --    d              --> Da1 + P2
%   5. Da1 + P3           --    a              --> Ce1
%   6. Ce1                --    d              --> Da1 + P3
%   7. D                  --    kw10           --> D1
%   8. Ca                 --    kw10           --> D1 + P1
%   9. D                  --    kmprime        --> D1
%  10. Ca                 --    kmprime        --> D1 + P1
%  11. D1                 --    deltaprime     --> D
%  12. D1 + P2            --    ktprime        --> D  +P2
%  13. D1 + Ct1           --    ktprimeact     --> D + Ct1 
%  14. D1                 --    kw20           --> D12
%  15. D1                 --    km             --> D12
%  16. D1                 --    kmbar          --> D12
%  17. D12                --    delta          --> D1
%  18. D12  + P3          --    ke             --> D1 + P3 
%  19. D12  + Ce1         --    keact          --> D1 + Ce1
%  20. D                  --    kw20           --> D2
%  21. Ca                 --    kw20           --> D2 + P1
%  22. D                  --    km             --> D2
%  23. Ca                 --    km             --> D2 + P1
%  24. D                  --    kmbar          --> D2
%  25. Ca                 --    kmbar          --> D2 + P1
%  26. D2                 --    delta          --> D
%  27. D2  + P3           --    ke             --> D  + P3 
%  28. D2  + Ce1          --    keact          --> D  + Ce1 
%  29. D2                 --    kw10           --> D12
%  30. D2                 --    kmprime        --> D12
%  31. D12                --    deltaprime     --> D2
%  32. D12 +P2            --    ktprime        --> D2 + P2  
%  33. D12 +Ct1           --    ktprimeact     --> D2 + Ct1
%  34. D                  --    kwa0           --> Da
%  35. Ca                 --    kwa0           --> Da + P1
%  36. Ca                 --    kwa            --> Da + P1
%  37. D                  --    kma            --> Da
%  38. Ca                 --    kma            --> Da + P1
%  39. Da                 --    delta          --> D
%  40. Da                 --    kea            --> D
%  41. Da                 --    keacta         --> D
%  42. Da                 --    keacta         --> D
%  43. Da                 --    b              --> Da+ P1
%  44. Ct1                --    b              --> Ct1+ P1
%  45. Ce1                --    b              --> Ce1+ P1
%  46. 0                  --    bo             --> P1
%  47. P1                 --    g              --> 0
%  48. Ca                 --    delta          --> D   + P1
%  49. Ct1                --    delta          --> Da1 + P2
%  50. Ce1                --    delta          --> Da1 + P3
%  51. D2   + P1          --    a              --> Ca2
%  52. Ca2                --    d              --> D2 + P1
%  53. Da2  + P2          --    a              --> Ct2
%  54. Ct2                --    d              --> Da2 + P2
%  55. Da2  + P3          --    a              --> Ce2
%  56. Ce2                --    d              --> Da2 + P3
%  57. D                  --    kw10           --> D1
%  58. Ca                 --    kw10           --> D1 + P1
%  59. D                  --    kmprime        --> D1
%  60. Ca                 --    kmprime        --> D1 + P1
%  61. D1                 --    deltaprime     --> D
%  62. D1 +P2             --    ktprime        --> D + P2
%  63. D1 Ct2             --    ktprimeact     --> D + Ct2
%  64. D1                 --    kw20           --> D12
%  65. D1                 --    km             --> D12
%  66. D1                 --    kmbar          --> D12
%  67. D12                --    delta          --> D1
%  68. D12  + P3          --    ke             --> D1 + P3
%  69. D12  + Ce2         --    keact          --> D1 + Ce2
%  70. D                  --    kw20           --> D2
%  71. Ca                 --    kw20           --> D2 + P1
%  72. D                  --    km             --> D2
%  73. Ca                 --    km             --> D2 + P1
%  74. D                  --    kmbar          --> D2
%  75. Ca                 --    kmbar          --> D2+ P1
%  76. D2                 --    delta          --> D
%  77. D2 + P3            --    ke             --> D + P3 
%  78. D2 + Ce2           --    keact          --> D + Ce2 
%  79. D2                 --    kw10           --> D12
%  80. D2                 --    kmprime        --> D12
%  81. D12                --    deltaprime     --> D2
%  82. D12+P2             --    ktprime        --> D2 + P2
%  83. D12+Ct2            --    ktprimeact     --> D2 + Ct2
%  84. D                  --    kwa0           --> Da
%  85. Ca                 --    kwa0           --> Da + P1
%  86. Ca                 --    kwa            --> Da + P1
%  87. D                  --    kma            --> Da
%  88. Ca                 --    kma            --> Da + P1
%  89. Da                 --    delta          --> D
%  90. Da                 --    kea            --> D
%  91. Da                 --    keacta         --> D
%  92. Da                 --    keacta         --> D
%  93. Da                 --    b              --> Da+ P2
%  94. Ct2                --    b              --> Ct2+ P2
%  95. Ce2                --    b              --> Ce2+ P2
%  96. 0                  --    bt             --> P2
%  97. P2                 --    g              --> 0
%  98. Ca2                --    delta          --> D2+P1
%  99. Ct2                --    delta          --> Da2+P2
% 100. Ce2                --    delta          --> Da2+P3
% 101. D3 + P1            --    a              --> Ca3
% 102. Ca3                --    d              --> D3 + P1
% 103. Da3 + P2           --    a              --> Ct3
% 104. Ct3                --    d              --> Da3 + P2
% 105. Da3  + P3          --    a              --> Ce3
% 106. Ce3                --    d              --> Da3 + P3
% 107. D                  --    kw10           --> D1
% 108. Ca                 --    kw10           --> D1 + P1
% 109. D                  --    kmprime        --> D1
% 110. Ca                 --    kmprime        --> D1 + P1
% 111. D1                 --    deltaprime     --> D
% 112. D1 + P2            --    ktprime        --> D + P2
% 113. D1 + Ct3           --    ktprimeact     --> D + Ct3
% 114. D1                 --    kw20           --> D12
% 115. D1                 --    km             --> D12
% 116. D1                 --    kmbar          --> D12
% 117. D12                --    delta          --> D1
% 118. D12  + P3          --    ke             --> D1 + P3
% 119. D12  + Ce3         --    keact          --> D1 + Ce3
% 120. D                  --    kw20           --> D2
% 121. Ca                 --    kw20           --> D2 + P1
% 122. D                  --    km             --> D2
% 123. Ca                 --    km             --> D2 + P1
% 124. D                  --    kmbar          --> D2
% 125. Ca                 --    kmbar          --> D2+ P1
% 126. D2                 --    delta          --> D
% 127. D2 + P3            --    ke             --> D + P3 
% 128. D2 + Ce3           --    keact          --> D + Ce3
% 129. D2                 --    kw10           --> D12
% 130. D2                 --    kmprime        --> D12
% 131. D12                --    deltaprime     --> D2
% 132. D12+P2             --    ktprime        --> D2 + P2
% 133. D12+Ct3            --    ktprimeact     --> D2 + Ct3
% 134. D                  --    kwa0           --> Da
% 135. Ca                 --    kwa0           --> Da + P1
% 136. Ca                 --    kwa            --> Da + P1
% 137. D                  --    kma            --> Da
% 138. Ca                 --    kma            --> Da + P1
% 139. Da                 --    delta          --> D
% 140. Da                 --    kea            --> D
% 141. Da                 --    keacta         --> D
% 142. Da                 --    keacta         --> D
% 143. Da                 --    b              --> Da+ P3
% 144. Ct3                --    b              --> Ct2+ P3
% 145. Ce3                --    b              --> Ce2+ P3
% 146. 0                  --    bt              --> P2
% 147. P2                 --    g              --> 0
% 148. Ca3                --    delta          --> D +P1
% 149. Ct3                --    delta          --> Da3+P2
% 150. Ce3                --    delta          --> Da3+P3

%% Parameter values

Dt = 50; 

p.V = 1; %Omega


p.a= 1; %(a_e)/(Omega)
p.d= 1; %d_e



p.a1= p.a ; %(a^d_t)/(Omega)
p.d1= p.d ; %d^d_t


p.bbx= 1; %alpha_O
p.bbz= 1; %alpha_T
p.bbw= 1; %alpha_J
p.gg= 1; %gamma_{O,T,J}


p.bo= 1; %u_O Omega

p.bt= 1; %u_T Omega

p.be= 1; %u_J Omega



p.kkw10= 1;      %k^1_{W0}

p.kkmprime= 1;   %(k'_M)/(Omega)

p.deltaprime=1;  %delta'
p.ktprime= 1;    %\hat k'_T/(Omega)
p.kktprime= 1;   %\tilde k^{'*}_T/(Omega^2)


%%%%

p.kkw20= 1;    %k^2_{W0}

p.kkm=1;       %(k_M)/(Omega)
p.kkmbar= 1;   %(\bar k_M)/(Omega)

p.delta= 1;    %delta
p.ke= 1;       %\hat k^R_E/(Omega)
p.kkeact= 1;   %\tilde k^R_E/(Omega^2)


%%%%



p.kkwa0= 1;   %k^A_{W0}
p.kkwa= 1;    %\tilde k^A_W/(Omega)

p.kkma= 1;    %\tilde k^A_M/(Omega)


p.kea= 1;     %\bar k^A_E

p.kkeacta= 1; %k^A_E/(Omega)



%% Initial conditions

% uncomment lines 231 - 265 when you want to study and visualize a single
% time trajectory. In particular, 
%1) Uncomment lines 231 - 247 to start from the fully active state
%2) Uncomment lines 249 - 265 to start from the fully repressed state

% 
D11_initial = 0;
D21_initial = 0;
D121_initial = 0;
Da1_initial = 50;
O_initial = (p.bbx/p.gg)*50;

D12_initial = 0;
D22_initial = 0;
D122_initial = 0;
Da2_initial = 50;
T_initial = (p.bbz/p.gg)*50;

D13_initial = 0;
D23_initial = 0;
D123_initial = 0;
Da3_initial = 50;
E_initial = (p.bbw/p.gg)*50;

% D11_initial = 0;
% D21_initial = 0;
% D121_initial = 50;
% Da1_initial = 0;
% O_initial = 0;
% 
% D12_initial = 0;
% D22_initial = 0;
% D122_initial = 50;
% Da2_initial = 0;
% T_initial = 0;
% 
% D13_initial = 0;
% D23_initial = 0;
% D123_initial = 50;
% Da3_initial = 0;
% E_initial = 0;


Ca1_initial = 0;
Ce1_initial = 0;
Ct1_initial = 0;

Ca2_initial = 0;
Ce2_initial = 0;
Ct2_initial = 0;

Ca3_initial = 0;
Ce3_initial = 0;
Ct3_initial = 0;

D1_initial = Dt - D11_initial - D21_initial - D121_initial - Da1_initial - Ca1_initial - Ct1_initial - Ce1_initial;

D2_initial = Dt - D12_initial - D22_initial - D122_initial - Da2_initial - Ca2_initial - Ct2_initial - Ce2_initial;

D3_initial = Dt - D13_initial - D23_initial - D123_initial - Da3_initial - Ca3_initial - Ct3_initial - Ce3_initial;



IC = [D1_initial*p.V, D11_initial*p.V, D21_initial*p.V, D121_initial*p.V, Da1_initial*p.V,  O_initial*p.V, ...
      D2_initial*p.V, D12_initial*p.V, D22_initial*p.V, D122_initial*p.V, Da2_initial*p.V, T_initial*p.V,...
      D3_initial*p.V, D13_initial*p.V, D23_initial*p.V, D123_initial*p.V, Da3_initial*p.V, E_initial*p.V,...
      Ca1_initial*p.V, Ct1_initial*p.V, Ce1_initial*p.V,...
      Ca2_initial*p.V, Ct2_initial*p.V, Ce2_initial*p.V,...
      Ca3_initial*p.V, Ct3_initial*p.V, Ce3_initial*p.V];

%% Initial state
tinterval = [0, 504];%hours --> this value multipled by Dt*p.kma will give the corresponding normalized time tau


x0    = IC;
x0    = round(x0);

%% Specify reaction network
pfun = @propensity_functions;

%species: D1, D11, D21, D121, Da1, O,    D2, D12, D22, D122, Da2, T,   
%D3,D13, D23, D123, Da3, E,   ca1,ct1, ce1, ca2, ct2, ce2, ca3, ct3, ce3

stoich_matrix = [-1  0  0  0  0 -1    0  0  0  0  0  0    0  0  0  0  0  0        1  0  0  0  0  0  0  0  0
                  1  0  0  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0
                  0  0  0  0 -1  0    0  0  0  0  0 -1    0  0  0  0  0  0        0  1  0  0  0  0  0  0  0
                  0  0  0  0  1  0    0  0  0  0  0  1    0  0  0  0  0  0        0 -1  0  0  0  0  0  0  0
                  0  0  0  0 -1  0    0  0  0  0  0  0    0  0  0  0  0 -1        0  0  1  0  0  0  0  0  0
                  0  0  0  0  1  0    0  0  0  0  0  0    0  0  0  0  0  1        0  0 -1  0  0  0  0  0  0                  
                 -1  1  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0              
                  0  1  0  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0
                 -1  1  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  1  0  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0
                  1 -1  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0   
                  1 -1  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0  
                  1 -1  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0                   
                  0 -1  0  1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0 -1  0  1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0 -1  0  1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  1  0 -1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  1  0 -1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  1  0 -1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                 -1  0  1  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  1  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0 
                 -1  0  1  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  1  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0 
                 -1  0  1  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  1  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0 
                  1  0 -1  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  1  0 -1  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  1  0 -1  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0 -1  1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0 -1  1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0        
                  0  0  1 -1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  1 -1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  1 -1  0  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0                
                 -1  0  0  0  1  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  1  1    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0
                  0  0  0  0  1  1    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0               
                 -1  0  0  0  1  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  1  1    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0 
                  1  0  0  0 -1  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  1  0  0  0 -1  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  1  0  0  0 -1  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  1  0  0  0 -1  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0 -1    0  0  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  1  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  0       -1  0  0  0  0  0  0  0  0
                  0  0  0  0  1  0    0  0  0  0  0  0    0  0  0  0  0  0        0 -1  0  0  0  0  0  0  0
                  0  0  0  0  1  0    0  0  0  0  0  0    0  0  0  0  0  0        0  0 -1  0  0  0  0  0  0
                  0  0  0  0  0 -1   -1  0  0  0  0  0    0  0  0  0  0  0        0  0  0  1  0  0  0  0  0
                  0  0  0  0  0  1    1  0  0  0  0  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0 -1 -1    0  0  0  0  0  0        0  0  0  0  1  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  1  1    0  0  0  0  0  0        0  0  0  0 -1  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0 -1  0    0  0  0  0  0 -1        0  0  0  0  0  1  0  0  0
                  0  0  0  0  0  0    0  0  0  0  1  0    0  0  0  0  0  1        0  0  0  0  0 -1  0  0  0
                  0  0  0  0  0  0   -1  1  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  1    0  1  0  0  0  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0
                  0  0  0  0  0  0   -1  1  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  1    0  1  0  0  0  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0
                  0  0  0  0  0  0    1 -1  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0  
                  0  0  0  0  0  0    1 -1  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0  
                  0  0  0  0  0  0    1 -1  0  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0                   
                  0  0  0  0  0  0    0 -1  0  1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0  
                  0  0  0  0  0  0    0 -1  0  1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0  
                  0  0  0  0  0  0    0 -1  0  1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0               
                  0  0  0  0  0  0    0  1  0 -1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0  
                  0  0  0  0  0  0    0  1  0 -1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0  
                  0  0  0  0  0  0    0  1  0 -1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0                   
                  0  0  0  0  0  0   -1  0  1  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  1    0  0  1  0  0  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0                    
                  0  0  0  0  0  0   -1  0  1  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  1    0  0  1  0  0  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0                   
                  0  0  0  0  0  0   -1  0  1  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  1    0  0  1  0  0  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0 
                  0  0  0  0  0  0    1  0 -1  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    1  0 -1  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    1  0 -1  0  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0               
                  0  0  0  0  0  0    0  0 -1  1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0 -1  1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  1 -1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  1 -1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  1 -1  0  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0           
                  0  0  0  0  0  0   -1  0  0  0  1  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0                
                  0  0  0  0  0  1    0  0  0  0  1  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0            
                  0  0  0  0  0  1    0  0  0  0  1  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0            
                  0  0  0  0  0  0   -1  0  0  0  1  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0                
                  0  0  0  0  0  1    0  0  0  0  1  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0
                  0  0  0  0  0  0    1  0  0  0 -1  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    1  0  0  0 -1  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    1  0  0  0 -1  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    1  0  0  0 -1  0    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  0  1    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0                 
                  0  0  0  0  0  0    0  0  0  0  0  1    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0          
                  0  0  0  0  0  0    0  0  0  0  0  1    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0         
                  0  0  0  0  0  0    0  0  0  0  0  1    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  0 -1    0  0  0  0  0  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    1  0  0  0  0  0    0  0  0  0  0  0        0  0  0 -1  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  1  0    0  0  0  0  0  0        0  0  0  0 -1  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  1  0    0  0  0  0  0  0        0  0  0  0  0 -1  0  0  0                  
                  0  0  0  0  0 -1    0  0  0  0  0  0   -1  0  0  0  0  0        0  0  0  0  0  0  1  0  0
                  0  0  0  0  0  1    0  0  0  0  0  0    1  0  0  0  0  0        0  0  0  0  0  0 -1  0  0
                  0  0  0  0  0  0    0  0  0  0  0 -1    0  0  0  0 -1  0        0  0  0  0  0  0  0  1  0
                  0  0  0  0  0  0    0  0  0  0  0  1    0  0  0  0  1  0        0  0  0  0  0  0  0 -1  0
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0 -1 -1        0  0  0  0  0  0  0  0  1
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0  1  1        0  0  0  0  0  0  0  0 -1
                  0  0  0  0  0  0    0  0  0  0  0  0   -1  1  0  0  0  0        0  0  0  0  0  0  0  0  0                  
                  0  0  0  0  0  1    0  0  0  0  0  0    0  1  0  0  0  0        0  0  0  0  0  0 -1  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0   -1  1  0  0  0  0        0  0  0  0  0  0  0  0  0                  
                  0  0  0  0  0  1    0  0  0  0  0  0    0  1  0  0  0  0        0  0  0  0  0  0 -1  0  0                  
                  0  0  0  0  0  0    0  0  0  0  0  0    1 -1  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    1 -1  0  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    1 -1  0  0  0  0        0  0  0  0  0  0  0  0  0                   
                  0  0  0  0  0  0    0  0  0  0  0  0    0 -1  0  1  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    0 -1  0  1  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    0 -1  0  1  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    0  1  0 -1  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    0  1  0 -1  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    0  1  0 -1  0  0        0  0  0  0  0  0  0  0  0                   
                  0  0  0  0  0  0    0  0  0  0  0  0   -1  0  1  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  1  0  0  0        0  0  0  0  0  0 -1  0  0                  
                  0  0  0  0  0  0    0  0  0  0  0  0   -1  0  1  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  1  0  0  0        0  0  0  0  0  0 -1  0  0                  
                  0  0  0  0  0  0    0  0  0  0  0  0   -1  0  1  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  1  0  0  0        0  0  0  0  0  0 -1  0  0  
                  0  0  0  0  0  0    0  0  0  0  0  0    1  0 -1  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    1  0 -1  0  0  0        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    1  0 -1  0  0  0        0  0  0  0  0  0  0  0  0               
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0 -1  1  0  0        0  0  0  0  0  0  0  0  0              
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0 -1  1  0  0        0  0  0  0  0  0  0  0  0                                
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  1 -1  0  0        0  0  0  0  0  0  0  0  0              
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  1 -1  0  0        0  0  0  0  0  0  0  0  0              
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  1 -1  0  0        0  0  0  0  0  0  0  0  0           
                  0  0  0  0  0  0    0  0  0  0  0  0   -1  0  0  0  1  0        0  0  0  0  0  0  0  0  0                
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  0  0  1  0        0  0  0  0  0  0 -1  0  0               
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  0  0  1  0        0  0  0  0  0  0 -1  0  0           
                  0  0  0  0  0  0    0  0  0  0  0  0   -1  0  0  0  1  0        0  0  0  0  0  0  0  0  0                
                  0  0  0  0  0  1    0  0  0  0  0  0    0  0  0  0  1  0        0  0  0  0  0  0 -1  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0    1  0  0  0 -1  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0    1  0  0  0 -1  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0    1  0  0  0 -1  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0    1  0  0  0 -1  0        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  1        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  1        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  1        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0  1        0  0  0  0  0  0  0  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0  0 -1        0  0  0  0  0  0  0  0  0 
                  0  0  0  0  0  0    0  0  0  0  0  0    1  0  0  0  0  0        0  0  0  0  0  0 -1  0  0
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0  1  0        0  0  0  0  0  0  0 -1  0
                  0  0  0  0  0  0    0  0  0  0  0  0    0  0  0  0  1  0        0  0  0   0  0  0 0  0 -1]; 
                  
                  
                                                                   
    

%% Run simulation:Direct method
[t,x] = directMethod2(stoich_matrix, pfun, tinterval, x0, p);

%% Save data

Xfin = [x];

Tfin =[t];

save('Xfin')

save('Tfin')


%% Plot time course - uncomment only when you want to visualize the plots

% use movingmean to visualize a smoother plot

 A1 =movingmean(Xfin(:,5),10,1);
 E1 =movingmean(Xfin(:,20),10,1); 
 G1 =movingmean(Xfin(:,21),10,1); 



















 

% 
figure(1)
hold on;
plot(Tfin/24,A1/p.V+E1/p.V+G1/p.V,'LineWidth',2);
set(gca, 'FontName', 'Times New Roman','xtick',[],'ytick',[])
box on
ax = gca;
ax.LineWidth = 1;
xlabel('time (days)');
ylabel('n^A_O');
axis([0 21 0 50]);


%% 
function a = propensity_functions(x, p, dd, dd2, bbt, bbe)

% Return reaction propensities given current state x

D1a         = x(1);
D11         = x(2);
D21         = x(3);
D121        = x(4);
Da1         = x(5);
P1          = x(6);
D2b         = x(7);
D12         = x(8);
D22         = x(9);
D122        = x(10);
Da2         = x(11);
P2          = x(12);
D3c         = x(13);
D13         = x(14);
D23         = x(15);
D123        = x(16);
Da3         = x(17);
P3          = x(18);
Ca1         = x(19);
Ct1         = x(20);
Ce1         = x(21);
Ca2         = x(22);
Ct2         = x(23);
Ce2         = x(24);
Ca3         = x(25);
Ct3         = x(26);
Ce3         = x(27);



p.kmprime1=(p.kkmprime*(D21+D121))/p.V;

p.km1=(p.kkm*(D21+D121))/p.V;

p.kmbar1=(p.kkmbar*(D11+D121))/p.V;

p.kma1=(p.kkma*(Da1))/p.V;



p.ktprimeact1=p.kktprime;

p.keact1=(p.kkeact*Da1)/p.V;

p.keacta11=(p.kkeacta*(D11+D121))/p.V;

p.keacta21=(p.kkeacta*(D21+D121))/p.V;


p.kw101=p.kkw10;

p.kw201=p.kkw20;

p.kwa01=p.kkwa0;
p.kwa1=p.kkwa;

p.b1=(p.bbx)/p.V;





p.kmprime2=(p.kkmprime*(D22+D122))/p.V;

p.km2=(p.kkm*(D22+D122))/p.V;

p.kmbar2=(p.kkmbar*(D12+D122))/p.V;

p.kma2=(p.kkma*(Da2))/p.V;



p.ktprimeact2=p.kktprime;

p.keact2=(p.kkeact*Da2)/p.V;

p.keacta12=(p.kkeacta*(D12+D122))/p.V;

p.keacta22=(p.kkeacta*(D22+D122))/p.V;



p.kw102=p.kkw10;

p.kw202=p.kkw20;

p.kwa02=p.kkwa0;
p.kwa2=p.kkwa;

p.b2=(p.bbz)/p.V;







p.kmprime3=(p.kkmprime*(D23+D123))/p.V;

p.km3=(p.kkm*(D23+D123))/p.V;

p.kmbar3=(p.kkmbar*(D13+D123))/p.V;

p.kma3=(p.kkma*(Da3))/p.V;



p.ktprimeact3=p.kktprime;

p.keact3=(p.kkeact*Da3)/p.V;

p.keacta13=(p.kkeacta*(D13+D123))/p.V;

p.keacta23=(p.kkeacta*(D23+D123))/p.V;



p.kw103=p.kkw10;

p.kw203=p.kkw20;

p.kwa03=p.kkwa0;
p.kwa3=p.kkwa;

p.b3=(p.bbw)/p.V;







a = [p.a*(D1a*P1)/p.V;
     p.d*Ca1;
     p.a1*(Da1*P2)/p.V;
     p.d1*Ct1;
     p.a1*(Da1*P3)/p.V;
     p.d1*Ce1;
     p.kw101*D1a;
     p.kw101*Ca1;   
     p.kmprime1*D1a;
     p.kmprime1*Ca1; 
     p.deltaprime*D11;  
     p.ktprime*(D11*P2)/p.V;
     p.ktprimeact1*(D11*Ct1)/p.V;
     p.kw201*D11;
     p.km1*D11;
     p.kmbar1*D11;
     p.delta*D121;
     p.ke*(D121*P3)/p.V;
     p.keact1*(D121*Ce1)/p.V;
     p.kw201*D1a;
     p.kw201*Ca1;
     p.km1*D1a;
     p.km1*Ca1;     
     p.kmbar1*D1a;
     p.kmbar1*Ca1;     
     p.delta*D21;
     p.ke*(D21*P3)/p.V;
     p.keact1*(D21*Ce1)/p.V;
     p.kw101*D21;
     p.kmprime1*D21;
     p.deltaprime*D121;
     p.ktprime*(D121*P2)/p.V;
     p.ktprimeact1*(D121*Ct1)/p.V;
     p.kwa01*D1a;
     p.kwa01*Ca1;    
     p.kwa1*Ca1;
     p.kma1*D1a;
     p.kma1*Ca1;
     p.delta*Da1;
     p.kea*Da1;
     p.keacta11*Da1;
     p.keacta21*Da1;
     p.b1*Da1;
     p.b1*Ct1;
     p.b1*Ce1;
     p.bo;
     p.gg*P1; 
     p.gg*Ca1;
     p.gg*Ct1; 
     p.gg*Ce1; 
     p.a*(D2b*P1)/p.V;
     p.d*Ca2;
     p.a1*(Da2*P2)/p.V;
     p.d1*Ct2;    
     p.a1*(Da2*P3)/p.V;
     p.d1*Ce2;        
     p.kw102*D2b;
     p.kw102*Ca2;
     p.kmprime2*D2b;
     p.kmprime2*Ca2;     
     p.deltaprime*D12;   
     p.ktprime*(D12*P2)/p.V;
     p.ktprimeact2*(D12*Ct2)/p.V;
     p.kw202*D12;
     p.km2*D12;
     p.kmbar2*D12;
     p.delta*D122;
     p.ke*(D122*P3)/p.V;
     p.keact2*(D122*Ce2)/p.V;
     p.kw202*D2b;
     p.kw202*Ca2;
     p.km2*D2b;
     p.km2*Ca2;     
     p.kmbar2*D2b;
     p.kmbar2*Ca2;
     p.delta*D22;
     p.ke*(D22*P3)/p.V;
     p.keact2*(D22*Ce2)/p.V;
     p.kw102*D22;          
     p.kmprime2*D22;
     p.deltaprime*D122;
     p.ktprime*(D122*P2)/p.V;
     p.ktprimeact2*(D122*Ct2)/p.V;
     p.kwa02*D2b;
     p.kwa02*Ca2;    
     p.kwa2*Ca2;
     p.kma2*D2b;
     p.kma2*Ca2;
     p.delta*Da2;
     p.kea*Da2;
     p.keacta12*Da2;
     p.keacta22*Da2;
     p.b2*(Da2);
     p.b2*(Ct2);
     p.b2*(Ce2);
     bbt*dd;
     p.gg*P2;
     p.gg*Ca2;
     p.gg*Ct2;
     p.gg*Ce2;      
     p.a*(D3c*P1)/p.V;
     p.d*Ca3;
     p.a1*(Da3*P2)/p.V;
     p.d1*Ct3;    
     p.a1*(Da3*P3)/p.V;
     p.d1*Ce3;        
     p.kw103*D3c;
     p.kw103*Ca3;
     p.kmprime3*D3c;
     p.kmprime3*Ca3;     
     p.deltaprime*D13;   
     p.ktprime*(D13*P2)/p.V;
     p.ktprimeact3*(D13*Ct3)/p.V;
     p.kw203*D13;
     p.km3*D13;
     p.kmbar3*D13;
     p.delta*D123;
     p.ke*(D123*P3)/p.V;
     p.keact3*(D123*Ce3)/p.V;
     p.kw203*D3c;
     p.kw203*Ca3;
     p.km3*D3c;
     p.km3*Ca3;     
     p.kmbar3*D3c;
     p.kmbar3*Ca3;
     p.delta*D23;
     p.ke*(D23*P3)/p.V;
     p.keact3*(D23*Ce3)/p.V;
     p.kw103*D23;          
     p.kmprime3*D23;
     p.deltaprime*D123;
     p.ktprime*(D123*P2)/p.V;
     p.ktprimeact3*(D123*Ct3)/p.V;
     p.kwa03*D3c;
     p.kwa03*Ca3;    
     p.kwa3*Ca3;
     p.kma3*D3c;
     p.kma3*Ca3;
     p.delta*Da3;
     p.kea*Da3;
     p.keacta13*Da3;
     p.keacta23*Da3;
     p.b3*(Da3);
     p.b3*(Ct3);
     p.b3*(Ce3);
     bbe*dd2;
     p.gg*P3;
     p.gg*Ca3;
     p.gg*Ct3;
     p.gg*Ce3];
 
end

function [ t, x ] = directMethod2( stoich_matrix, pfun, tinterval, x0,...
                                  p)
    %% Initialization

max_out_length=1000000;
num_rxns = size(stoich_matrix, 1);
num_species = size(stoich_matrix, 2);
T = zeros(max_out_length, 1);
X = zeros(max_out_length, num_species);
DEC = zeros(max_out_length, 1);
DEC2 = zeros(max_out_length, 1);
T(1)     = tinterval(1);
X(1,:)   = x0;
rxn_count = 1;
DEC(1)=1;
DEC2(1)=1;
bbbt(1)=0;
bbbe(1)=0;


%% MAIN LOOP
%while tau > 0.000000001 
while T(rxn_count) < tinterval(2);

%%% Uncomment lines 834 - 887 to evaluate the process efficiency
%         
%  if X(rxn_count,5)+X(rxn_count,20)+X(rxn_count,21)>40;       
%     
%     % Calculate reaction propensities
%     a = pfun(X(rxn_count,:), p, DEC(rxn_count), DEC2(rxn_count), bbbt(rxn_count), bbbe(rxn_count));
%     
%     % Sample earliest time-to-fire (tau)
%     a0 = sum(a);
%     r = rand(1,1);
%     
%     % Sample identity of earliest reaction channel to fire (mu)
%     j=1; s=a(1); r0=r*a0;
%     while s < r0
%       j = j + 1;
%       s = s + a(j);
%     end
%     
%     % Sample earliest time-to-fire (tau)
%     
%     s2= s -a(j);
% 
%     r2 = (r0 - s2)/a(j);
%     
%     tau = -log(r2)/a0; %(1/a0)*log(1/r2);
%     
% 
% 
% ddayy=1;
% 
% 
%     if T(rxn_count)<ddayy*24;
% 
%         bbbt(rxn_count+1)=p.bt;
% 
%         bbbe(rxn_count+1)=0;
% 
%     else
%         bbbt(rxn_count+1)=p.bt;
% 
%         bbbe(rxn_count+1)=p.be;
%     end
%         
% 
% 
%     % Update time and carry out reaction mu
%     T(rxn_count+1)   = T(rxn_count)   + tau;
%     X(rxn_count+1,:) = X(rxn_count,:) + stoich_matrix(j,:); 
%     DEC(rxn_count+1)=exp(-p.delta*T(rxn_count+1));      
%     DEC2(rxn_count+1)=exp(-p.delta*(T(rxn_count+1)-ddayy*24));   
%     rxn_count = rxn_count + 1;
%     
%     
%    
% break
% end     
    
    % Calculate reaction propensities
    a = pfun(X(rxn_count,:), p, DEC(rxn_count), DEC2(rxn_count), bbbt(rxn_count), bbbe(rxn_count));
    
    % Sample earliest time-to-fire (tau)
    a0 = sum(a);
    r = rand(1,1);
    
    % Sample identity of earliest reaction channel to fire (mu)
    j=1; s=a(1); r0=r*a0;
    while s < r0
      j = j + 1;
      s = s + a(j);
    end
    
    % Sample earliest time-to-fire (tau)
    
    s2= s -a(j);

    r2 = (r0 - s2)/a(j);
    
    tau = -log(r2)/a0; %(1/a0)*log(1/r2);


ddayy=1;


    if T(rxn_count)<ddayy*24;


        bbbt(rxn_count+1)=p.bt;

        bbbe(rxn_count+1)=0;

    else
        bbbt(rxn_count+1)=p.bt;

        bbbe(rxn_count+1)=p.be;
    end
        
    

    % Update time and carry out reaction mu
    T(rxn_count+1)   = T(rxn_count)   + tau;
    X(rxn_count+1,:) = X(rxn_count,:) + stoich_matrix(j,:);    
    DEC(rxn_count+1)=exp(-p.delta*T(rxn_count+1));   
    DEC2(rxn_count+1)=exp(-p.delta*(T(rxn_count+1)-ddayy*24));  
    rxn_count = rxn_count + 1;
    
     
end  

% Return simulation time course
t = T(1:rxn_count);
x = X(1:rxn_count,:);
dec = DEC(1:rxn_count);
dec2 = DEC2(1:rxn_count);
if t(end) > tinterval(2)
    t(end) = tinterval(2);
    x(end,:) = X(rxn_count-1,:);
end    

end
end