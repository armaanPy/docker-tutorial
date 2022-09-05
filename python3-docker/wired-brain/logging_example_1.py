import logging

# Basic configuration
logging.basicConfig(format='%(asctime)s %(levelname)-8s %(name)-10s: %(message)s') # Timestamps included
# logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(levelname)-8s %(name)-10s: %(message)s')


log = logging.getLogger(__name__)  # This means that logger names track the package/module hierarchy, and it’s intuitively obvious where events are logged just from the logger name.

log.debug('DEBUG message')
log.info('INFO message')
log.warning('WARNING message')
log.error('ERROR message')
log.critical('CRITICAL message')