# 가상화폐 가격 등락 예측
가상화폐의 시계열 데이터(종가 및 현재가)를 이용하여 가상화폐 가격의 등락 예측

## 프로젝트 기간
2021-11-29 ~ 2021-12-24

## 사용기술
- Python
- Pandas
- scikit-learn
- Keras LSTM  

## 활용 데이터
- 국내 가상화폐 가격 데이터 : Upbit API
- 해외 가상화폐 가격 데이터 : Bifinex(investing.com 데이터 크롤링)

## 결과
- 20일간의 가격데이터를 통한 등락 예측
  - Test_Data Accuracy : 0.74
- 20일간의 가격데이터를 통해 변동 범위 예측
  - Test_Data Accuracy 기준
    - 5% 이상 상승 : 0.73
    - 5% 이상 하락 : 0.81 
