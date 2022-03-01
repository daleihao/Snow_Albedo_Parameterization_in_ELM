FSA_TOP = ncread('test_f09_globe_TOP_ELMv2.f09_f09.IELM.intel.elm.h0.2000-02-01-00000.nc','EFLX_LH_TOT');
FSA_PP = ncread('test_f09_globe_PP_ELMv2.f09_f09.IELM.intel.elm.h0.2000-02-01-00000.nc','EFLX_LH_TOT');
FSA_TOP = squeeze(FSA_TOP(:,:,1));
FSA_PP = squeeze(FSA_PP(:,:,1));
figure;
imagesc(flip(FSA_TOP'-FSA_PP'))


FSA_TOP = ncread('test_v2_f09_globe_TOP_ELMv2.f09_f09.IELM.intel.elm.h0.2000-01.nc','EFLX_LH_TOT');
FSA_PP = ncread('test_v2_f09_globe_PP_ELMv2.f09_f09.IELM.intel.elm.h0.2000-01.nc','EFLX_LH_TOT');
FSA_TOP = squeeze(FSA_TOP(:,:,1));
FSA_PP = squeeze(FSA_PP(:,:,1));
figure;
imagesc(flip(FSA_TOP'-FSA_PP'))


FSA_TOP = ncread('test_v2_f09_globe_TOP_ELMv2.f09_f09.IELM.intel.elm.h0.2000-01.nc','EFLX_LH_TOT');
FSA_PP = ncread('test_v2_f09_globe_PP_ELMv2.f09_f09.IELM.intel.elm.h0.2000-01.nc','EFLX_LH_TOT');
FSA_TOP = squeeze(FSA_TOP(:,:,1));
FSA_PP = squeeze(FSA_PP(:,:,1));
figure;
imagesc(flip(FSA_TOP'-FSA_PP'))