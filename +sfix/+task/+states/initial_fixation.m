function state = initial_fixation(program, conf)

state = ptb.State();
state.Name = 'initial_fixation';
state.Duration = conf.TIMINGS.time_in.initial_fixation;

state.Entry = @(state) entry(state, program);
state.Loop = @(state) loop(state, program);
state.Exit = @(state) exit(state, program);

end

function entry(state, program)

state.UserData.acquired = false;
state.UserData.entered = false;
state.UserData.broke = false;

stimuli = program.Value.stimuli;
targets = program.Value.targets;
window = program.Value.window;

reset( targets.initial_fixation );
draw( stimuli.initial_fixation, window );
flip( window );

end

function loop(state, program)

targ = program.Value.targets.initial_fixation;

if ( targ.IsInBounds )
  state.UserData.entered = true;
  
elseif ( state.UserData.entered )
  state.UserData.broke = true;
  escape( state );
  return
end

end

function exit(state, program)

states = program.Value.states;

if ( state.UserData.broke )
  next( state, states('error_timeout') );
else
  data = sfix.util.data_this_trial( program );
  trial_type = data.trial_type;
  
  switch ( trial_type )
    case 'randomized_fixation'
      next( state, states('randomized_fixation') );
    case 'cs_presentation'
      next( state, states('cs_presentation') );
    case 'image_presentation'
      next( state, states('image_presentation') );
    otherwise
      error( 'Unrecognized trial type "%s".', trial_type );
  end
end

end