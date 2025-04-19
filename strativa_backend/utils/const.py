import uuid


class BackendConstants:
    card_expiry_years = 3
    otp_length = 4
    otp_valid_duration = 60

    def get_uuid(half=False):
        if half:
            return uuid.uuid4().hex[:16].upper()
        else:
            return uuid.uuid4().hex.upper()