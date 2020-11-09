conf = sfix.config.reconcile( sfix.config.load() );

% screen
conf.SCREEN.rect = [0, 0, 800, 800];
conf.SCREEN.calibration_rect = [0, 0, 800, 800];
conf.SCREEN.index = 0;

% stimuli
conf.STIMULI.setup.initial_fixation.size = [100, 100];  % px
conf.STIMULI.setup.image.size = [100, 100];

conf.STIMULI.setup.randomized_fixation.size = [100, 100];
conf.STIMULI.setup.randomized_fixation.color = [255, 0, 0];
conf.STIMULI.setup.randomized_fixation.target_duration_range = [0.1, 0.5];

conf.STIMULI.setup.cue_no_reward.color;
conf.STIMULI.setup.cue_no_reward.size;

conf.STIMULI.setup.cue_small_reward.color;
conf.STIMULI.setup.cue_small_reward.size;

conf.STIMULI.setup.cue_large_reward.color;
conf.STIMULI.setup.cue_large_reward.size;

% timings
conf.TIMINGS.time_in.cs_delay = 0.3;
conf.TIMINGS.time_in.cs_presentation = 0.5;
conf.TIMINGS.time_in.cs_reward = 0.2;

conf.TIMINGS.time_in.randomized_fixation = 1;
conf.TIMINGS.time_in.image_presentation = 1;
conf.TIMINGS.time_in.error_timeout = 1;
conf.TIMINGS.time_in.iti_range = [1, 2];

% rewards
conf.REWARDS.fixation_trial;
conf.REWARDS.cs_small;
conf.REWARDS.cs_large;

% interface
conf.INTERFACE.gaze_source_type = 'mouse';  % 'mouse', 'digital_eyelink', 'analog_input'
conf.INTERFACE.reward_output_type = 'none'; % 'arduino', 'ni', 'none'
conf.INTERFACE.save_data = false;

% paths
conf.PATHS.images;  % where to load images from.
conf.PATHS.data;    % where to save data to.

sfix.task.start( conf );