try:
    from robot.libraries.BuiltIn import BuiltIn
    from robot.libraries.BuiltIn import _Misc
    import robot.api.logger as logger
    from robot.api.deco import keyword
    ROBOT = False
except Exception:
    ROBOT = False

def getUserIdFromMessage(text):
    return text.split(" ")[-1].split("|")[0]

def getZoneIdFromMessage(text):
    return text.split(" ")[-1].split("|")[1]

def getUsernameFromSuccessMessage(text):
    return text.split(" ")[1]