function state = image_presentation(program, conf)

state = ptb.State();
state.Name = 'image_presentation';
state.Duration = conf.TIMINGS.time_in.image_presentation;

state.Entry = @(state) entry(state, program);
state.Exit = @(state) exit(state, program);

end

function entry(state, program)

data = sfix.util.data_this_trial( program );
data.event_times.image_presentation.entry = elapsed( program.Value.task );

stim = program.Value.stimuli.image;
img = data.image;

if ( ~isempty(img) )
  stim.FaceColor = img;  
  draw( stim, program.Value.window );
  flip( program.Value.window );
end

data.event_times.image_presentation.image_onset = elapsed( program.Value.task );

end

function exit(state, program)

next( state, program.Value.states('iti') );

end