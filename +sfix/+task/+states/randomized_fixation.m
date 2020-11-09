function state = randomized_fixation(program, conf)

state = ptb.State();
state.Name = 'randomized_fixation';
state.Duration = conf.TIMINGS.time_in.randomized_fixation;

state.Entry = @(state) entry(state, program);
state.Loop = @(state) loop(state, program);
state.Exit = @(state) exit(state, program);

end

function entry(state, program)

state.UserData.acquired = false;
state.UserData.target_acquired_time = nan;
state.UserData.target_entry_time = nan;
state.UserData.entered = false;
state.UserData.broke = false;
state.UserData.draw_stimulus = true;

data = sfix.util.data_this_trial( program );
stimuli = program.Value.stimuli;
targets = program.Value.targets;
window = program.Value.window;

dur_range = ...
  program.Value.stimuli_setup.randomized_fixation.target_duration_range;

[targ_duration, targ_position] = ...
  configure_target( stimuli.randomized_fixation, targets.randomized_fixation, window, dur_range );

data.event_times.randomized_fixation.entry = elapsed( program.Value.task );
data.randomized_fixation_position = targ_position;
data.randomized_fixation_duration = targ_duration;

reset( targets.randomized_fixation );
draw( stimuli.randomized_fixation, window );
flip( window );

end

function loop(state, program)

targ = program.Value.targets.randomized_fixation;

if ( targ.IsDurationMet )
  if ( ~state.UserData.acquired )
    state.UserData.target_acquired_time = elapsed( program.Value.task );
  end
  
  state.UserData.acquired = true;
  state.UserData.draw_stimulus = false;
  
elseif ( targ.IsInBounds )
  if ( ~state.UserData.entered )
    state.UserData.target_entry_time = elapsed( program.Value.task );
  end
  state.UserData.entered = true;
  
elseif ( state.UserData.entered )
  state.UserData.broke = true;
end

if ( ~state.UserData.draw_stimulus )
  flip( program.Value.window );
end

end

function exit(state, program)

if ( state.UserData.acquired )
  reward_time = program.Value.rewards.fixation_trial;
  sfix.util.deliver_reward( program, 1, reward_time );
end

states = program.Value.states;
next( state, states('iti') );

if ( state.UserData.acquired )
  data = sfix.util.data_this_trial( program );
  data.event_times.randomized_fixation.target_acquired = state.UserData.target_acquired_time;
  data.event_times.randomized_fixation.target_entry = state.UserData.target_entry_time;
end

end

function [targ_dur, pixel_pos] = configure_target(stimulus, target, window, dur_range)

targ_dur = (dur_range(2) - dur_range(1)) * rand() + dur_range(1);
target.Duration = targ_dur;

p = rand( 2, 1 );
stimulus.Position = set( stimulus.Position, p );
pixel_pos = as_px( stimulus.Position, window );

end