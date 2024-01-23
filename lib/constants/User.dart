class ConstantUser {
  static const locations = [('서울', '서울'), ('경기', '경기')];
  static const locationsJson = {'서울': '서울', '경기': '경기'};
  static const List<(String, String)> sexOptions = [
    ('ALL', '모든 성별'),
    ('FEMALE', '여성'),
    ('MALE', '남성')
  ];
  static const sexOptionsJson = {
    'ALL': '모든 성별',
    'FEMALE': '여성',
    'MALE': '남성',
  };

  static const matchingEventsJson = {
    'CONNECT': "connect",
    'DISCONNECT': "disconnect",
    'INTRODUCE_EACH_USER': "introduce_each_user",
    'MATCH_RESULT': "match_result",
    'EXCEPTION': "exception",
    'RESTART_MATCHING_REQUEST': "restart_matching_request",
    'NOT_IDLE': "not_idle",
    'NOT_WAITING': "not_waiting",
    'PARTNER_DISCONNECTED': "partner_disconnected",
    'START_MATCHING': "start_matching",
    'CANCEL_MATCHING': "cancel_matching",
    'RESPOND_TO_INTRODUCE': "respond_to_introduce",
  };

  static const webrtcEvents = {
    'START_WEBRTC_SIGNALING': "start_webrtc_signaling",
    'OFFER': "offer",
    'ANSWER': "answer",
    'ICE': "ice",
  };

  static const purposes = [
    ['진지한 연애', '진지한연애'],
    ['새로운 친구', '새로운친구'],
    ['술 한잔', '술한잔'],
    ['커피 한잔', '커피한잔'],
  ];
}
